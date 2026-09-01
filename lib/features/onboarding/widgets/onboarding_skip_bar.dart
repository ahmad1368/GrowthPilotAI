import 'package:flutter/material.dart';

/// Transparent top bar with the "Skip" control (Issue #162 AC:
/// "Dismissibility") for [OnboardingTourScreen].
class OnboardingSkipBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onSkip;
  const OnboardingSkipBar({super.key, required this.onSkip});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: [TextButton(onPressed: onSkip, child: const Text('Skip'))],
    );
  }
}
