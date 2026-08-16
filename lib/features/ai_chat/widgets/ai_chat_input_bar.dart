import 'package:flutter/material.dart';

/// Text field + send button for the chat window (Issue #200).
class AiChatInputBar extends StatefulWidget {
  final ValueChanged<String> onSubmit;
  const AiChatInputBar({super.key, required this.onSubmit});

  @override
  State<AiChatInputBar> createState() => _AiChatInputBarState();
}

class _AiChatInputBarState extends State<AiChatInputBar> {
  final _controller = TextEditingController();

  void _submit() {
    final text = _controller.text;
    if (text.trim().isEmpty) return;
    widget.onSubmit(text);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(children: [
        Expanded(
          child: TextField(
            controller: _controller,
            decoration: const InputDecoration(hintText: 'Ask about your business...', isDense: true),
            onSubmitted: (_) => _submit(),
          ),
        ),
        IconButton(icon: const Icon(Icons.send_rounded), onPressed: _submit),
      ]),
    );
  }
}
