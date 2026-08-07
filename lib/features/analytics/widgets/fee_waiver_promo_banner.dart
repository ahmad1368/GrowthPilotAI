import 'package:flutter/material.dart';

/// Onboarding banner highlighting the zero-commission incentive
/// (Issue #420, acceptance criterion 3) — this app has no onboarding-
/// tutorial system, so the highlight is this flat, always-visible
/// banner shown while the merchant hasn't claimed a waiver yet.
class FeeWaiverPromoBanner extends StatelessWidget {
  const FeeWaiverPromoBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: scheme.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        'Your first marketplace sale or purchase is commission-free — 100% of proceeds go to you.',
        style: TextStyle(fontSize: 12, color: scheme.primary),
      ),
    );
  }
}
