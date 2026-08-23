import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/group_chat_messages_by_date.dart';
import 'package:growth_pilot_ai/core/data/entities/chat_room_message_entity.dart';
import 'package:growth_pilot_ai/features/chat/widgets/chat_date_divider.dart';
import 'package:growth_pilot_ai/features/chat/widgets/chat_message_bubble.dart';

/// Optimized Message List (Issue #123/#136 AC): a lazy [ListView.builder]
/// over date-grouped messages, interleaving [ChatDateDivider]s. Keys each
/// bubble by message id to support the "Scroll-to-Parent" AC (Issue #132).
class ChatMessageList extends StatelessWidget {
  final List<ChatRoomMessageEntity> messages;
  final String currentUserId;
  final void Function(ChatRoomMessageEntity) onReply;
  final void Function(ChatRoomMessageEntity) onForward;
  final void Function(ChatRoomMessageEntity) onEdit;
  final void Function(ChatRoomMessageEntity) onDelete;
  final void Function(ChatRoomMessageEntity) onTogglePin;
  final String? themeColorHex;

  const ChatMessageList({
    super.key,
    required this.messages,
    required this.currentUserId,
    required this.onReply,
    required this.onForward,
    required this.onEdit,
    required this.onDelete,
    required this.onTogglePin,
    this.themeColorHex,
  });

  @override
  Widget build(BuildContext context) {
    if (messages.isEmpty) {
      return const Center(child: Text('No messages yet', style: TextStyle(fontSize: 12)));
    }
    final keys = {for (final m in messages) m.id: GlobalKey()};
    final groups = GroupChatMessagesByDate.call(messages, DateTime.now());
    final items = <Widget>[];
    for (final group in groups) {
      items.add(ChatDateDivider(label: group.dateLabel));
      items.addAll(group.messages.map((m) => KeyedSubtree(
            key: keys[m.id],
            child: ChatMessageBubble(
              message: m,
              isMe: m.senderId == currentUserId,
              onReply: () => onReply(m),
              onForward: () => onForward(m),
              onEdit: m.senderId == currentUserId ? () => onEdit(m) : null,
              onDelete: m.senderId == currentUserId ? () => onDelete(m) : null,
              onTogglePin: () => onTogglePin(m),
              themeColorHex: themeColorHex,
              onTapReplyPreview:
                  m.replyToMessageId == null ? null : () => _scrollTo(keys[m.replyToMessageId]),
            ),
          )));
    }
    return ListView.builder(itemCount: items.length, itemBuilder: (context, i) => items[i]);
  }

  void _scrollTo(GlobalKey? key) {
    final ctx = key?.currentContext;
    if (ctx == null) return;
    Scrollable.ensureVisible(ctx, duration: const Duration(milliseconds: 400), curve: Curves.easeInOutCubic);
  }
}
