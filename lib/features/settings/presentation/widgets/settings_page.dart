import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/features/settings/presentation/widgets/developer_tools_card.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          isDark ? const Color(0xff09090b) : const Color(0xffffffff),
      appBar: AppBar(
        backgroundColor:
            isDark ? const Color(0xff09090b) : const Color(0xffffffff),
        elevation: 0,
        title: Text("Settings", style: theme.textTheme.h3),
        leading: IconButton(
          icon: Icon(Icons.close_rounded,
              color: isDark ? Colors.white : Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          if (kDebugMode) ...[
            Text("Developer Tools",
                style: theme.textTheme.p
                    .copyWith(color: Colors.blue, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            const DeveloperToolsCard(),
          ],
          const SizedBox(height: 20),
          Text("App Version: 1.0.0 (Build 2026)",
              style: theme.textTheme.muted.copyWith(fontSize: 12)),
        ],
      ),
    );
  }
}
