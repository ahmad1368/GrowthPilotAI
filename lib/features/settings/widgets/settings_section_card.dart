import 'package:flutter/material.dart';

/// [Issue #808] Thin bordered wrapper shared by Settings sections that
/// don't already provide their own card chrome — matches the border
/// style used throughout the former single-file SettingsScreen.
class SettingsSectionCard extends StatelessWidget {
  final Widget child;
  const SettingsSectionCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: onSurface.withValues(alpha: 0.1)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
    );
  }
}
