import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/services/environment_service.dart';
import '../widgets/omni_glass_panel.dart';
import '../widgets/adaptive_text.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final envService = Get.find<EnvironmentService>();

    return Scaffold(
      backgroundColor: Colors.transparent, // برای حفظ تم شیشه‌ای پس‌زمینه
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const AdaptiveText("Settings", fontWeight: FontWeight.bold),
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () => Get.back(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          if (kDebugMode) ...[
            const AdaptiveText(
              "Developer Tools",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent),
            ),
            const SizedBox(height: 12),
            OmniGlassPanel(
              opacity: 0.1,
              isInteractive: true,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const AdaptiveText(
                          "Remote Access",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        AdaptiveText(
                          "Toggle between Local and Cloud DB",
                          style: TextStyle(
                              fontSize: 12,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withValues(alpha: 0.6)),
                        ),
                      ],
                    ),
                  ),
                  Obx(() => Switch(
                        value: envService.isRemoteEnabled.value,
                        onChanged: (val) => envService.toggleDataSource(val),
                        activeColor: Colors.greenAccent,
                      )),
                ],
              ),
            ),
          ],

          // سایر تنظیمات عمومی در آینده اینجا اضافه می‌شوند
          const SizedBox(height: 20),
          const AdaptiveText("App Version: 1.0.0 (Build 2026)",
              style: TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }
}
