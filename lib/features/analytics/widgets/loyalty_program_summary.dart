import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/loyalty_program_effectiveness.dart';
import 'package:growth_pilot_ai/core/utils/currency_format.dart';

/// KPI row for the simulated loyalty program (Issue #396).
class LoyaltyProgramSummary extends StatelessWidget {
  final LoyaltyProgramEffectiveness effectiveness;

  const LoyaltyProgramSummary({super.key, required this.effectiveness});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Points liability', style: TextStyle(fontSize: 11)),
              Text(CurrencyFormat.cad(effectiveness.liabilityCost)),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Repeat-buyer revenue', style: TextStyle(fontSize: 11)),
              Text(CurrencyFormat.cad(effectiveness.repeatCustomerRevenue)),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: (effectiveness.isEffective ? scheme.primary : scheme.error)
                .withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            '${effectiveness.roiRatio.toStringAsFixed(1)}x ROI',
            style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: effectiveness.isEffective ? scheme.primary : scheme.error),
          ),
        ),
      ],
    );
  }
}
