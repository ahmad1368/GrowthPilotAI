import 'package:growth_pilot_ai/core/data/entities/chat_room_message_entity.dart';

/// One "Sticky Date Header" bucket of same-day messages (Issue #123/#136).
class ChatMessageGroup {
  final String dateLabel;
  final List<ChatRoomMessageEntity> messages;

  ChatMessageGroup(this.dateLabel, this.messages);
}
