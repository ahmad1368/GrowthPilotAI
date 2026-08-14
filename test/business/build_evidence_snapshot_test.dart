import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_evidence_snapshot.dart';
import 'package:growth_pilot_ai/core/data/entities/chat_room_message_entity.dart';

void main() {
  final now = DateTime(2026, 1, 1);

  ChatRoomMessageEntity msg(String sender, String body) =>
      ChatRoomMessageEntity(roomId: 1, senderId: sender, body: body, sentAt: now);

  test('keeps only the last 10 messages', () {
    final messages = List.generate(15, (i) => msg('u$i', 'body$i'));
    final snapshot = BuildEvidenceSnapshot.call(messages);
    expect(snapshot.split('\n'), hasLength(10));
    expect(snapshot, contains('u14: body14'));
    expect(snapshot, isNot(contains('u4: body4')));
  });

  test('keeps everything when under the cap', () {
    final messages = [msg('a', 'hi'), msg('b', 'hello')];
    expect(BuildEvidenceSnapshot.call(messages), 'a: hi\nb: hello');
  });
}
