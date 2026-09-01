import 'package:flutter/material.dart';

/// Row of dots showing tour progress (Issue #162) — flat, filled dot for
/// the active page.
class OnboardingPageIndicator extends StatelessWidget {
  final int count;
  final int activeIndex;
  const OnboardingPageIndicator({super.key, required this.count, required this.activeIndex});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (i) {
        final isActive = i == activeIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: isActive ? 20 : 6,
          height: 6,
          decoration: BoxDecoration(
            color: isActive ? color : color.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(3),
          ),
        );
      }),
    );
  }
}
