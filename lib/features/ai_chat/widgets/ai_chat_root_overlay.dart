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

    // [Issue #796] HomeLayout's floating bottom nav bar (HomeBottomNav) sits
    // inset by a 20px bottom margin plus its own ~56px BottomNavigationBar
    // height. A plain `bottom: 16` here (measured from the raw screen edge)
    // put the FAB right on top of the nav bar's last item. This offset
    // clears it with a small gap; screens without the nav bar just get a
    // FAB sitting a bit higher than the very edge, which is harmless.
    const fabBottomOffset = 96.0;

    return Stack(children: [
      child,
      const Positioned(right: 16, bottom: fabBottomOffset, child: AiChatFab()),
      Positioned(
        right: 16,
        bottom: fabBottomOffset,
        child: Obx(() => controller.isOpen.value && !controller.isMinimized.value
            ? const AiChatWindow()
            : const SizedBox.shrink()),
      ),
    ]);
  }
}
