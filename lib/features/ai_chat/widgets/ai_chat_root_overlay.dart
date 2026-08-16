import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/ai_chat_controller.dart';
import 'package:growth_pilot_ai/features/ai_chat/widgets/ai_chat_window.dart';
import 'package:growth_pilot_ai/widgets/ai_chat_fab.dart';

/// Wraps the whole app so the Floating Financial Assistant (Issue #200)
/// stays available over every screen without any of them needing to
/// know about it.
class AiChatRootOverlay extends StatelessWidget {
  final Widget child;
  const AiChatRootOverlay({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    Get.put(AiChatController(), permanent: true);
    final controller = Get.find<AiChatController>();

    return Stack(children: [
      child,
      const Positioned(right: 16, bottom: 16, child: AiChatFab()),
      Positioned(
        right: 16,
        bottom: 16,
        child: Obx(() => controller.isOpen.value && !controller.isMinimized.value
            ? const AiChatWindow()
            : const SizedBox.shrink()),
      ),
    ]);
  }
}
