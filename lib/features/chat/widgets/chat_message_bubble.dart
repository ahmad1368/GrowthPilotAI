import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/parse_hex_color.dart';
import 'package:growth_pilot_ai/core/data/entities/chat_room_message_entity.dart';
import 'package:growth_pilot_ai/features/chat/widgets/chat_attachment_chip.dart';
import 'package:growth_pilot_ai/features/chat/widgets/chat_message_tag_chips.dart';
import 'package:growth_pilot_ai/features/chat/widgets/chat_reply_preview.dart';
import 'package:growth_pilot_ai/features/chat/widgets/show_chat_message_actions.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Flat message bubble (Issue #123/#136) — the issues ask for a
/// Glassmorphism/BackdropFilter "frosted" bubble, which this project's
/// architecture explicitly forbids; uses the theme's primary/card colors
/// instead, matching [CatalogGridCard]'s precedent. Long-press opens the
/// Reply/Forward action sheet (Issue #132).
class ChatMessageBubble extends StatelessWidget {
  final ChatRoomMessageEntity message;
  final bool isMe;
  final VoidCallback? onTapReplyPreview;
  final VoidCallback onReply;
  final VoidCallback onForward;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback onTogglePin;
  final String? themeColorHex;

  const ChatMessageBubble({
    super.key,
    required this.message,
    required this.isMe,
    this.onTapReplyPreview,
    required this.onReply,
    required this.onForward,
    this.onEdit,
    this.onDelete,
    required this.onTogglePin,
    this.themeColorHex,
  });

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    final time = TimeOfDay.fromDateTime(message.sentAt).format(context);
    final bubbleColor =
        isMe && themeColorHex != null ? ParseHexColor.call(themeColorHex!) : (isMe ? colors.primary : colors.card);
    final fg = isMe ? colors.primaryForeground : colors.foreground;
    return Align(
      alignment: isMe ? AlignmentDirectional.centerEnd : AlignmentDirectional.centerStart,
      child: GestureDetector(
        onLongPress: message.isDeleted
            ? null
            : () => showChatMessageActions(context,
                onReply: onReply,
                onForward: onForward,
                onEdit: onEdit,
                onDelete: onDelete,
                onTogglePin: onTogglePin,
                isPinned: message.isPinned),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          constraints: const BoxConstraints(maxWidth: 280),
          decoration: BoxDecoration(
            color: bubbleColor,
            border: isMe ? null : Border.all(color: colors.border),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
            if (message.isPinned && !message.isDeleted)
              Padding(
                padding: const EdgeInsets.only(bottom: 2),
                child: Icon(Icons.push_pin, size: 12, color: fg.withValues(alpha: 0.7)),
              ),
            if (message.isDeleted)
              Text('This message was deleted',
                  style: TextStyle(fontStyle: FontStyle.italic, color: fg.withValues(alpha: 0.6)))
            else ...[
              if (message.isForwarded)
                Text('Forwarded', style: TextStyle(fontSize: 10, fontStyle: FontStyle.italic, color: fg.withValues(alpha: 0.7))),
              if (message.isReply)
                ChatReplyPreview(text: message.replyPreviewText ?? '', onTap: onTapReplyPreview),
              if (message.hasAttachment)
                ChatAttachmentChip(
                  bytes: message.attachmentBytes!,
                  fileName: message.attachmentFileName ?? '',
                  fileSize: message.attachmentFileSize ?? 0,
                  mimeType: message.attachmentMimeType ?? '',
                )
              else
                Text(message.body, style: TextStyle(color: fg)),
            ],
            if (message.metadataTags.isNotEmpty) ...[
              const SizedBox(height: 2),
              ChatMessageTagChips(tags: message.metadataTags),
            ],
            const SizedBox(height: 2),
            Row(mainAxisSize: MainAxisSize.min, children: [
              if (message.isEdited && !message.isDeleted) ...[
                Text('edited', style: TextStyle(fontSize: 10, fontStyle: FontStyle.italic, color: fg.withValues(alpha: 0.7))),
                const SizedBox(width: 4),
              ],
              Text(time, style: TextStyle(fontSize: 10, color: fg.withValues(alpha: 0.7))),
              if (isMe) ...[
                const SizedBox(width: 4),
                Icon(message.isRead ? Icons.done_all : Icons.done, size: 12, color: fg.withValues(alpha: 0.7)),
              ],
            ]),
          ]),
        ),
      ),
    );
  }
}
