import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_response_velocity_score.dart';
import 'package:growth_pilot_ai/core/data/entities/chat_room_message_entity.dart';

void main() {
  final base = DateTime(2026, 1, 1, 9);

  ChatRoomMessageEntity msg(String sender, DateTime sentAt, {int roomId = 1}) =>
      ChatRoomMessageEntity(roomId: roomId, senderId: sender, body: 'hi', sentAt: sentAt);

  test('scores near 1.0 for an instant reply', () {
    final messages = [
      msg('buyer', base),
      msg('biz-1', base.add(const Duration(minutes: 1))),
    ];
    expect(ComputeResponseVelocityScore.call(messages, 'biz-1'), closeTo(1.0, 0.01));
  });

  test('scores near 0.0 for a reply after the 24h threshold', () {
    final messages = [
      msg('buyer', base),
      msg('biz-1', base.add(const Duration(hours: 30))),
    ];
    expect(ComputeResponseVelocityScore.call(messages, 'biz-1'), 0.0);
  });

  test('returns a neutral score when there is no data at all', () {
    expect(ComputeResponseVelocityScore.call([], 'biz-1'), 0.5);
  });

  test('ignores a customer message that never got a reply', () {
    final messages = [msg('buyer', base)];
    expect(ComputeResponseVelocityScore.call(messages, 'biz-1'), 0.5);
  });

  test('does not pair messages across different rooms', () {
    final messages = [
      msg('buyer', base, roomId: 1),
      msg('biz-1', base.add(const Duration(minutes: 1)), roomId: 2),
    ];
    expect(ComputeResponseVelocityScore.call(messages, 'biz-1'), 0.5);
  });
}
