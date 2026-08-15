import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/onboarding_step.dart';

/// One tour page's icon/title/description (Issue #162) — flat, no
/// Glassmorphism (this app's architecture forbids BackdropFilter).
class OnboardingStepPage extends StatelessWidget {
  final OnboardingStep step;
  const OnboardingStepPage({super.key, required this.step});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(step.icon, size: 72, color: theme.colorScheme.primary),
          const SizedBox(height: 24),
          Text(step.title, style: theme.textTheme.headlineSmall, textAlign: TextAlign.center),
          const SizedBox(height: 12),
          Text(step.description,
              style: theme.textTheme.bodyMedium
                  ?.copyWith(color: theme.colorScheme.onSurface.withValues(alpha: 0.7)),
              textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
