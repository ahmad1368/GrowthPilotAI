import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/features/onboarding/widgets/onboarding_page_indicator.dart';

/// Progress dots + Next/Done button for [OnboardingTourScreen] (Issue #162).
class OnboardingTourBottomBar extends StatelessWidget {
  final int stepCount;
  final int activeIndex;
  final bool isLast;
  final VoidCallback onNext;

  const OnboardingTourBottomBar({
    super.key,
    required this.stepCount,
    required this.activeIndex,
    required this.isLast,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OnboardingPageIndicator(count: stepCount, activeIndex: activeIndex),
        Padding(
          padding: const EdgeInsets.all(24),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(onPressed: onNext, child: Text(isLast ? 'Done' : 'Next')),
          ),
        ),
      ],
    );
  }
}
