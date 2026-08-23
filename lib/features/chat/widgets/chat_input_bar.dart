import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/features/chat/widgets/chat_reply_banner.dart';
import 'package:growth_pilot_ai/features/chat/widgets/pick_chat_attachment.dart';
import 'package:growth_pilot_ai/features/chat/widgets/sticker_picker_sheet.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Contextual Action Bar (Issue #123/#136 AC) — a flat text field, send
/// button, and image attach button (Issue #133; location shortcut #121
/// is a future issue). [replyPreview] shows a cancellable "Replying
/// to…" banner (Issue #132).
class ChatInputBar extends StatefulWidget {
  final void Function(String text, bool isSilent) onSend;
  final void Function(String fileName, String mimeType, Uint8List bytes) onSendAttachment;
  final void Function(String text, DateTime scheduledFor) onSchedule;
  final String? replyPreview;
  final VoidCallback? onCancelReply;

  const ChatInputBar({
    super.key,
    required this.onSend,
    required this.onSendAttachment,
    required this.onSchedule,
    this.replyPreview,
    this.onCancelReply,
  });

  @override
  State<ChatInputBar> createState() => _ChatInputBarState();
}

class _ChatInputBarState extends State<ChatInputBar> {
  final _controller = TextEditingController();
  bool _isSilent = false;

  void _submit() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    widget.onSend(text, _isSilent);
    _controller.clear();
    setState(() => _isSilent = false);
  }

  Future<void> _attach() async {
    final picked = await pickChatAttachment();
    if (picked == null) return;
    widget.onSendAttachment(picked.fileName, picked.mimeType, picked.bytes);
  }

  /// "Custom Stickers and Vector Emojis" (Issue #317 feature #23) — a
  /// sticker is just sent as a normal message (no new dispatch path).
  void _openStickers() =>
      showStickerPickerSheet(context, onSelect: (emoji) => widget.onSend(emoji, _isSilent));

  /// "Schedule Send" (Issue #317 feature #20).
  Future<void> _schedule() async {
    final text = _controller.text.trim();
    if (text.isEmpty || !mounted) return;
    final date = await showDatePicker(
        context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime.now().add(const Duration(days: 365)));
    if (date == null || !mounted) return;
    final time = await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (time == null) return;
    widget.onSchedule(text, DateTime(date.year, date.month, date.day, time.hour, time.minute));
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
        if (widget.replyPreview != null)
          ChatReplyBanner(preview: widget.replyPreview!, onCancel: widget.onCancelReply),
        Row(children: [
          ShadButton.ghost(onPressed: _attach, child: const Icon(Icons.attach_file, size: 16)),
          ShadButton.ghost(onPressed: _openStickers, child: const Icon(Icons.emoji_emotions_outlined, size: 16)),
          ShadButton.ghost(onPressed: _schedule, child: const Icon(Icons.schedule_send_outlined, size: 16)),
          // "Silent Messages" (Issue #317 feature #21) — toggled per send.
          ShadButton.ghost(
            onPressed: () => setState(() => _isSilent = !_isSilent),
            child: Icon(_isSilent ? Icons.notifications_off : Icons.notifications_off_outlined, size: 16),
          ),
          Expanded(
            child: ShadInput(
              controller: _controller,
              placeholder: const Text('Message'),
              onSubmitted: (_) => _submit(),
            ),
          ),
          const SizedBox(width: 8),
          ShadButton(onPressed: _submit, child: const Icon(Icons.send_rounded, size: 16)),
        ]),
      ]),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
