import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:growth_pilot_ai/core/models/pulse_gratification_result.dart';

/// "Live Rewards (Instant Gratification)" banner (Issue #267/#268):
/// "Your alert helped 47 financial managers protect an estimated
/// $12,000 in transactions".
class PulseGratificationBanner extends StatelessWidget {
  final PulseGratificationResult result;

  const PulseGratificationBanner({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: colors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colors.primary),
      ),
      child: Row(children: [
        Icon(Icons.bolt_rounded, color: colors.primary),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            'Your alert helped an estimated ${result.estimatedPeopleHelped} teams protect '
            '\$${result.estimatedValueProtectedCad.toStringAsFixed(0)} CAD — '
            '+${result.growthScoreEarned} GrowthScore',
            style: TextStyle(color: colors.foreground, fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ),
      ]),
    );
  }
}
