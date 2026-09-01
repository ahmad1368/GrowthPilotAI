import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/onboarding_step.dart';

/// Platform-specific tour content (Issue #162 AC: "Platform Specificity"
/// — mobile focuses on "Field" features, web on "Desktop-only" ones).
class BuildOnboardingSteps {
  static List<OnboardingStep> call({required bool isWeb}) {
    if (isWeb) {
      return const [
        OnboardingStep(
          icon: Icons.upload_file_rounded,
          title: 'Bulk Import',
          description: 'Drag and drop a spreadsheet to import your whole catalog at once.',
        ),
        OnboardingStep(
          icon: Icons.bar_chart_rounded,
          title: 'Analytics Dashboard',
          description: 'Filter and sort your data tables to spot trends fast.',
        ),
      ];
    }
    return const [
      OnboardingStep(
        icon: Icons.camera_alt_rounded,
        title: 'Scan Invoices',
        description: 'Tap the camera button to scan a paper invoice into a transaction.',
      ),
      OnboardingStep(
        icon: Icons.swipe_rounded,
        title: 'Swipe Actions',
        description: 'Swipe a chat message or notification for quick actions.',
      ),
      OnboardingStep(
        icon: Icons.storefront_rounded,
        title: 'Marketplace vs My Orders',
        description: 'Use the bottom tabs to switch between browsing and your own orders.',
      ),
    ];
  }
}
