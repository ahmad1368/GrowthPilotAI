import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/group_chat_messages_by_date.dart';
import 'package:growth_pilot_ai/core/data/entities/chat_room_message_entity.dart';

void main() {
  final now = DateTime(2026, 3, 15, 9);

  ChatRoomMessageEntity message(DateTime sentAt) => ChatRoomMessageEntity(
      roomId: 1, senderId: 'a', body: 'hi', sentAt: sentAt);

  test('groups same-day messages under one header', () {
    final groups = GroupChatMessagesByDate.call(
        [message(DateTime(2026, 3, 15, 8)), message(DateTime(2026, 3, 15, 8, 30))], now);
    expect(groups, hasLength(1));
    expect(groups.single.dateLabel, 'Today');
    expect(groups.single.messages, hasLength(2));
  });

  test('splits messages from different days into separate groups', () {
    final groups = GroupChatMessagesByDate.call(
        [message(DateTime(2026, 3, 14)), message(DateTime(2026, 3, 15, 8))], now);
    expect(groups, hasLength(2));
    expect(groups[0].dateLabel, 'Yesterday');
    expect(groups[1].dateLabel, 'Today');
  });

  test('returns an empty list for no messages', () {
    expect(GroupChatMessagesByDate.call([], now), isEmpty);
  });
}
