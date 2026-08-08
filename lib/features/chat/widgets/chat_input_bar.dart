import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Contextual Action Bar (Issue #123/#136 AC) — a flat text field + send
/// button; media/location shortcuts (#133/#121) are a future issue.
/// [replyPreview] shows a cancellable "Replying to…" banner (Issue #132).
class ChatInputBar extends StatefulWidget {
  final void Function(String) onSend;
  final String? replyPreview;
  final VoidCallback? onCancelReply;

  const ChatInputBar(
      {super.key, required this.onSend, this.replyPreview, this.onCancelReply});

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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
        if (widget.replyPreview != null)
          Row(children: [
            Expanded(
                child: Text('Replying to: ${widget.replyPreview}',
                    maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 11))),
            IconButton(
                icon: const Icon(Icons.close, size: 14),
                onPressed: widget.onCancelReply,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints()),
          ]),
        Row(children: [
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
