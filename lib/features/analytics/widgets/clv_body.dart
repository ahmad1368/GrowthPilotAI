import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/build_clv_narrative.dart';
import 'package:growth_pilot_ai/business/compute_cohort_clv_comparison.dart';
import 'package:growth_pilot_ai/business/compute_customer_lifetime_values.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/clv_cohort_comparison_bar.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/clv_top_customers_list.dart';

/// Body of the Customer Lifetime Value Analytics widget (Issue #394).
class ClvBody extends StatelessWidget {
  final List<TransactionEntity> transactions;

  const ClvBody({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    final clvs = ComputeCustomerLifetimeValues.call(transactions, DateTime.now());
    final comparison = ComputeCohortClvComparison.call(clvs);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClvCohortComparisonBar(comparison: comparison),
        const SizedBox(height: 12),
        const Text('Top projected value',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
        const SizedBox(height: 4),
        ClvTopCustomersList(clvs: clvs),
        const SizedBox(height: 8),
        Text(BuildClvNarrative.call(comparison)),
      ],
    );
  }
}
