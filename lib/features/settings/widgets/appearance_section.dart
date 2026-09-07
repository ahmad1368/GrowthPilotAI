import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:growth_pilot_ai/core/theme/app_design_tokens.dart';
import 'package:growth_pilot_ai/widgets/theme_toggle.dart';

/// [Issue #808] "App Theme" light/dark toggle row, Settings > General.
class AppearanceSection extends StatelessWidget {
  const AppearanceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = AdaptiveTheme.of(context).mode.isDark;
    return Container(
      decoration: BoxDecoration(
        color: AppDesignTokens.card(theme.brightness),
        borderRadius: BorderRadius.circular(AppDesignTokens.radiusMd),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        leading: Icon(
          isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
          color: isDark ? Colors.cyanAccent : Colors.orangeAccent,
          size: 28,
        ),
        title: Text("App Theme",
            style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
        subtitle: Text(
          "Switch between Day and Night",
          style: theme.textTheme.bodySmall
              ?.copyWith(fontSize: 12, color: theme.colorScheme.onSurface.withValues(alpha: 0.6)),
        ),
        // [Issue #806] ListTile needs a bounded trailing width, or its
        // own intrinsic-width computation crashes.
        trailing: const SizedBox(width: 60, child: ThemeToggle()),
      ),
    );
  }
}
