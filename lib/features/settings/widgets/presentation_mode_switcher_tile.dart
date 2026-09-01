import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:growth_pilot_ai/services/presentation_mode_service.dart';

/// Debug-only "camera ready" toggle for App Preview video recording
/// (Issue #195) — seeds clean demo data and suppresses in-app
/// notification banners while enabled.
class PresentationModeSwitcherTile extends StatelessWidget {
  const PresentationModeSwitcherTile({super.key});

  @override
  Widget build(BuildContext context) {
    final presentation = Get.find<PresentationModeService>();
    final colors = ShadTheme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: colors.card, borderRadius: BorderRadius.circular(12)),
      child: Obx(() => ShadSwitch(
            value: presentation.isEnabled.value,
            onChanged: presentation.toggle,
            label: Text('Presentation Mode', style: TextStyle(color: colors.foreground, fontWeight: FontWeight.bold)),
            sublabel: Text('Seeds clean demo data and hides in-app notification banners',
                style: TextStyle(color: colors.mutedForeground, fontSize: 12)),
          )),
    );
  }
}
