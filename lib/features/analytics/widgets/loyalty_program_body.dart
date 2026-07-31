import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/build_loyalty_program_narrative.dart';
import 'package:growth_pilot_ai/business/compute_loyalty_program_effectiveness.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/loyalty_program_summary.dart';

/// Body of the Loyalty Program Effectiveness Evaluator (Issue #396).
class LoyaltyProgramBody extends StatelessWidget {
  final List<TransactionEntity> transactions;

  const LoyaltyProgramBody({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    final effectiveness = ComputeLoyaltyProgramEffectiveness.call(transactions);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LoyaltyProgramSummary(effectiveness: effectiveness),
        const SizedBox(height: 8),
        Text(BuildLoyaltyProgramNarrative.call(effectiveness)),
      ],
    );
  }
}
