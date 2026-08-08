import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/group_chat_messages_by_date.dart';
import 'package:growth_pilot_ai/core/data/entities/chat_room_message_entity.dart';
import 'package:growth_pilot_ai/features/chat/widgets/chat_date_divider.dart';
import 'package:growth_pilot_ai/features/chat/widgets/chat_message_bubble.dart';

/// Optimized Message List (Issue #123/#136 AC): a lazy [ListView.builder]
/// over date-grouped messages, interleaving [ChatDateDivider]s.
class ChatMessageList extends StatelessWidget {
  final List<ChatRoomMessageEntity> messages;
  final String currentUserId;

  const ChatMessageList({super.key, required this.messages, required this.currentUserId});

  @override
  Widget build(BuildContext context) {
    if (messages.isEmpty) {
      return const Center(child: Text('No messages yet', style: TextStyle(fontSize: 12)));
    }
    final groups = GroupChatMessagesByDate.call(messages, DateTime.now());
    final items = <Widget>[];
    for (final group in groups) {
      items.add(ChatDateDivider(label: group.dateLabel));
      items.addAll(group.messages.map((m) =>
          ChatMessageBubble(message: m, isMe: m.senderId == currentUserId)));
    }
    return ListView.builder(
      reverse: false,
      itemCount: items.length,
      itemBuilder: (context, i) => items[i],
    );
  }
}
