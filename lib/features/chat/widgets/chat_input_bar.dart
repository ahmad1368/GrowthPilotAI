import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/features/chat/widgets/chat_reply_banner.dart';
import 'package:growth_pilot_ai/features/chat/widgets/pick_chat_attachment.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Contextual Action Bar (Issue #123/#136 AC) — a flat text field, send
/// button, and image attach button (Issue #133; location shortcut #121
/// is a future issue). [replyPreview] shows a cancellable "Replying
/// to…" banner (Issue #132).
class ChatInputBar extends StatefulWidget {
  final void Function(String) onSend;
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

  void _submit() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    widget.onSend(text);
    _controller.clear();
  }

  Future<void> _attach() async {
    final picked = await pickChatAttachment();
    if (picked == null) return;
    widget.onSendAttachment(picked.fileName, picked.mimeType, picked.bytes);
  }

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
          ShadButton.ghost(onPressed: _schedule, child: const Icon(Icons.schedule_send_outlined, size: 16)),
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
