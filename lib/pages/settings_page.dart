import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/features/settings/widgets/data_source_switcher_tile.dart';
import '../widgets/adaptive_text.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
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
        children: const [
          if (kDebugMode) ...[
            AdaptiveText(
              "Developer Tools",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent),
            ),
            SizedBox(height: 12),
            DataSourceSwitcherTile(),
          ],

          // سایر تنظیمات عمومی در آینده اینجا اضافه می‌شوند
          SizedBox(height: 20),
          AdaptiveText("App Version: 1.0.0 (Build 2026)",
              style: TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }
}
