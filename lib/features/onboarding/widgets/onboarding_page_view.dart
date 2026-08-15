import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/onboarding_step.dart';
import 'package:growth_pilot_ai/features/onboarding/widgets/onboarding_step_page.dart';

/// The scrollable step content for [OnboardingTourScreen] (Issue #162).
class OnboardingPageView extends StatelessWidget {
  final PageController controller;
  final List<OnboardingStep> steps;
  final ValueChanged<int> onPageChanged;

  const OnboardingPageView({
    super.key,
    required this.controller,
    required this.steps,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: controller,
      itemCount: steps.length,
      onPageChanged: onPageChanged,
      itemBuilder: (context, i) => OnboardingStepPage(step: steps[i]),
    );
  }
}
