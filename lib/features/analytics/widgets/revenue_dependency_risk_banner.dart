import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/revenue_dependency_snapshot.dart';

/// Warning banner shown when one buyer accounts for an outsized share of
/// revenue (Issue #376).
class RevenueDependencyRiskBanner extends StatelessWidget {
  final RevenueDependencySnapshot snapshot;

  const RevenueDependencyRiskBanner({super.key, required this.snapshot});

  @override
  Widget build(BuildContext context) {
    if (!snapshot.isConcentrationRisk) return const SizedBox.shrink();
    final scheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: scheme.error.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        'Concentration risk: over-reliant on a narrow customer base',
        style: TextStyle(
            fontSize: 11, color: scheme.error, fontWeight: FontWeight.w600),
      ),
    );
  }
}
