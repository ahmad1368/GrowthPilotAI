import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/core/theme/app_design_tokens.dart';

/// [Issue #815] Honest placeholder for the Profile bottom-nav tab, which
/// previously fell through to the same InsightPage content as Home —
/// tapping it looked like nothing happened. No real profile feature
/// exists yet, so this states that plainly (matching the drawer's
/// "Coming Soon" convention from #802) instead of silently reusing Home.
class ProfilePlaceholderPage extends StatelessWidget {
  const ProfilePlaceholderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final onSurface = theme.colorScheme.onSurface;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppDesignTokens.card(theme.brightness),
              borderRadius: BorderRadius.circular(AppDesignTokens.radiusLg),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.person_rounded,
                    size: 48, color: onSurface.withValues(alpha: 0.4)),
                const SizedBox(height: 16),
                Text('nav_profile'.tr,
                    style: theme.textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text('common_coming_soon'.tr,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(color: onSurface.withValues(alpha: 0.6))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
