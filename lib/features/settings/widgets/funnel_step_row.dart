import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// One funnel stage's count + drop-off bar (Issue #194's "Conversion
/// Funnel: Install -> Onboarding -> First Scan -> Subscription").
class FunnelStepRow extends StatelessWidget {
  final String label;
  final int count;
  final int maxCount;

  const FunnelStepRow({super.key, required this.label, required this.count, required this.maxCount});

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    final ratio = maxCount == 0 ? 0.0 : count / maxCount;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(label, style: TextStyle(color: colors.foreground)),
          Text('$count', style: TextStyle(color: colors.mutedForeground)),
        ]),
        const SizedBox(height: 4),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: ratio.clamp(0.0, 1.0),
            minHeight: 6,
            backgroundColor: colors.border,
            valueColor: AlwaysStoppedAnimation(colors.primary),
          ),
        ),
      ]),
    );
  }
}
