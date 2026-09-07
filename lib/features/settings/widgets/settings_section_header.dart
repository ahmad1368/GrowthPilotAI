import 'package:flutter/material.dart';

/// [Issue #808] Uppercase section-label header shared by every Settings
/// tab (extracted from the former single-file SettingsScreen).
class SettingsSectionHeader extends StatelessWidget {
  final String title;
  const SettingsSectionHeader(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.2,
            color: Colors.blueAccent),
      ),
    );
  }
}
