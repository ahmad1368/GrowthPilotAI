import 'package:growth_pilot_ai/business/build_chat_date_label.dart';
import 'package:growth_pilot_ai/core/data/entities/chat_room_message_entity.dart';
import 'package:growth_pilot_ai/core/models/chat_message_group.dart';

/// Buckets chronological messages into date-labeled groups for the
/// "Sticky Date Headers" AC (Issue #123/#136).
class GroupChatMessagesByDate {
  static List<ChatMessageGroup> call(
      List<ChatRoomMessageEntity> messages, DateTime now) {
    final groups = <ChatMessageGroup>[];
    for (final message in messages) {
      final label = BuildChatDateLabel.call(message.sentAt, now);
      if (groups.isNotEmpty && groups.last.dateLabel == label) {
        groups.last.messages.add(message);
      } else {
        groups.add(ChatMessageGroup(label, [message]));
      }
    }
    return groups;
  }
}
