import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/build_revenue_dependency_narrative.dart';
import 'package:growth_pilot_ai/business/compute_revenue_dependency_snapshot.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/revenue_dependency_breakdown_bar.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/revenue_dependency_risk_banner.dart';

/// Body of the Revenue Dependency on Loyal Customers widget (Issue #376).
class RevenueDependencyBody extends StatelessWidget {
  final List<TransactionEntity> transactions;

  const RevenueDependencyBody({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    final snapshot = ComputeRevenueDependencySnapshot.call(transactions);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RevenueDependencyRiskBanner(snapshot: snapshot),
        RevenueDependencyBreakdownBar(snapshot: snapshot),
        const SizedBox(height: 8),
        Text(
          '${snapshot.repeatCustomerCount} repeat buyers · '
          '${snapshot.oneTimeCustomerCount} one-time buyers',
          style: const TextStyle(fontSize: 11),
        ),
        const SizedBox(height: 8),
        Text(BuildRevenueDependencyNarrative.call(snapshot)),
      ],
    );
  }
}
