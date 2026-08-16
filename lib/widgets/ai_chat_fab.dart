import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/ai_chat_controller.dart';

/// Persistent floating button that opens the chat from any screen
/// (Issue #200 AC: "toggled from any screen via a floating button").
/// Hidden while the chat is already open (the window has its own
/// close/minimize controls).
class AiChatFab extends StatelessWidget {
  const AiChatFab({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AiChatController>();
    return Obx(() {
      if (controller.isOpen.value && !controller.isMinimized.value) return const SizedBox.shrink();
      return FloatingActionButton(
        heroTag: 'aiChatFab',
        onPressed: controller.open,
        child: const Icon(Icons.smart_toy_outlined),
      );
    });
  }
}
