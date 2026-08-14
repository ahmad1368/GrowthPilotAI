import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// "Contribution" badge (Issue #87 AC): shows the user their buffered
/// feedback events are helping refine the community's Success Signature
/// benchmarks. Flat pill, no glassmorphism.
class ContributionBadge extends StatelessWidget {
  final int contributedCount;

  const ContributionBadge({super.key, required this.contributedCount});

  @override
  Widget build(BuildContext context) {
    if (contributedCount <= 0) return const SizedBox.shrink();
    final colors = ShadTheme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
          border: Border.all(color: colors.primary), borderRadius: BorderRadius.circular(20)),
      child: Text('Contributing $contributedCount insight${contributedCount == 1 ? '' : 's'} to the community',
          style: TextStyle(color: colors.primary, fontSize: 11)),
    );
  }
}
