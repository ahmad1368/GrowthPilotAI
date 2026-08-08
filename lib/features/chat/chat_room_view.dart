import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/chat_gateway_controller.dart';
import 'package:growth_pilot_ai/core/theme/app_shad_theme.dart';
import 'package:growth_pilot_ai/features/chat/widgets/chat_input_bar.dart';
import 'package:growth_pilot_ai/features/chat/widgets/chat_message_list.dart';
import 'package:growth_pilot_ai/features/chat/widgets/chat_room_header.dart';
import 'package:growth_pilot_ai/features/chat/widgets/chat_typing_indicator.dart';

/// Marketplace chat screen (Issue #123, near-duplicate #136) — flat
/// shadcn_ui, not the issues' literal Glassmorphism ask (architecture
/// forbids Glassmorphism/BackdropFilter; see [CatalogGridCard]
/// precedent). Not yet wired into app navigation — pushed directly with
/// the two participant ids once a "Message Seller" entry point exists.
class ChatRoomView extends StatefulWidget {
  final String currentUserId;
  final String otherUserId;

  const ChatRoomView({super.key, required this.currentUserId, required this.otherUserId});

  @override
  State<ChatRoomView> createState() => _ChatRoomViewState();
}

class _ChatRoomViewState extends State<ChatRoomView> {
  late final String _tag = '${widget.currentUserId}_${widget.otherUserId}';
  late final ChatGatewayController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Get.put(ChatGatewayController(), tag: _tag);
    _controller.openRoom(widget.currentUserId, widget.otherUserId);
    _controller.markMessagesRead(widget.currentUserId);
  }

  @override
  void dispose() {
    Get.delete<ChatGatewayController>(tag: _tag);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return ShadTheme(
      data: AppShadTheme.build(brightness),
      child: Scaffold(
        backgroundColor: brightness == Brightness.dark
            ? const Color(0xFF09090B)
            : const Color(0xFFFFFFFF),
        body: SafeArea(
          child: Obx(() => Column(children: [
                ChatRoomHeader(
                  otherUserId: widget.otherUserId,
                  isOnline: _controller.room?.isOtherOnline ?? false,
                  onToggleOnline: _controller.toggleOtherOnline,
                ),
                ChatTypingIndicator(isTyping: _controller.room?.isOtherTyping ?? false),
                Expanded(
                  child: ChatMessageList(
                    messages: _controller.messages,
                    currentUserId: widget.currentUserId,
                  ),
                ),
                ChatInputBar(
                  onSend: (text) => _controller.sendMessage(widget.currentUserId, text),
                ),
              ])),
        ),
      ),
    );
  }
}
