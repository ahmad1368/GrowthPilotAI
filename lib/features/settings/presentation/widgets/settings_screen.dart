import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/features/settings/presentation/widgets/settings_sections.dart';
import 'package:growth_pilot_ai/utils/ui_helper.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          isDark ? const Color(0xff09090b) : const Color(0xffffffff),
      appBar: AppBar(
        elevation: 0,
        backgroundColor:
            isDark ? const Color(0xff09090b) : const Color(0xffffffff),
        centerTitle: true,
        title: Text("Settings", style: theme.textTheme.h3),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded,
              color: isDark ? Colors.white : Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Container(
          width: UIHelper.getAdaptiveWidth(context),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: const SettingsSections(),
        ),
      ),
    );
  }
}
