import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/build_dependency_trigger_narrative.dart';
import 'package:growth_pilot_ai/core/data/entities/merchant_dependency_evaluation_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/merchant_dependency_tier_badge.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// One merchant's dependency status, liquidation-percent input, and
/// evaluate/log-visit actions (Issue #424, acceptance criteria 1-5).
class MerchantDependencyMerchantRow extends StatelessWidget {
  final String merchantName;
  final MerchantDependencyEvaluationEntity? evaluation;
  final double liquidationPercent;
  final VoidCallback onLogVisit;
  final void Function(double) onSetLiquidation;
  final VoidCallback onEvaluate;

  const MerchantDependencyMerchantRow({
    super.key,
    required this.merchantName,
    required this.evaluation,
    required this.liquidationPercent,
    required this.onLogVisit,
    required this.onSetLiquidation,
    required this.onEvaluate,
  });

  @override
  Widget build(BuildContext context) {
    final e = evaluation;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Expanded(child: Text(merchantName, style: const TextStyle(fontSize: 12))),
            MerchantDependencyTierBadge(evaluation: e),
            const SizedBox(width: 8),
            ShadButton.ghost(onPressed: onLogVisit, child: const Text('Log Visit')),
            ShadButton.ghost(onPressed: onEvaluate, child: const Text('Evaluate')),
          ]),
          Row(children: [
            Text('Inventory liquidated: ${liquidationPercent.toStringAsFixed(0)}%',
                style: const TextStyle(fontSize: 11)),
            Expanded(
              child: Slider(
                value: liquidationPercent.clamp(0, 100).toDouble(),
                min: 0,
                max: 100,
                divisions: 20,
                onChanged: onSetLiquidation,
              ),
            ),
          ]),
          if (e != null)
            Text(BuildDependencyTriggerNarrative.call(e),
                style: const TextStyle(fontSize: 11, fontStyle: FontStyle.italic)),
        ],
      ),
    );
  }
}
