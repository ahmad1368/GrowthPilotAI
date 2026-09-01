import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/chat_message.dart';
import 'package:growth_pilot_ai/features/ai_chat/widgets/ai_chat_bubble.dart';

/// Scrollable message history, auto-scrolled to the newest message as
/// it streams in (Issue #200 AC: "Auto-Scroll").
class AiChatMessageList extends StatefulWidget {
  final List<ChatMessage> messages;
  const AiChatMessageList({super.key, required this.messages});

  @override
  State<AiChatMessageList> createState() => _AiChatMessageListState();
}

class _AiChatMessageListState extends State<AiChatMessageList> {
  final _controller = ScrollController();

  @override
  void didUpdateWidget(covariant AiChatMessageList oldWidget) {
    super.didUpdateWidget(oldWidget);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_controller.hasClients) return;
      _controller.jumpTo(_controller.position.maxScrollExtent);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _controller,
      padding: const EdgeInsets.all(12),
      itemCount: widget.messages.length,
      itemBuilder: (context, i) => AiChatBubble(message: widget.messages[i]),
    );
  }
}
