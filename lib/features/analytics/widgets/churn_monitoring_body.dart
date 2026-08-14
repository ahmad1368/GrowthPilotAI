import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/build_churn_retention_narrative.dart';
import 'package:growth_pilot_ai/business/compute_churn_retention_snapshot.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/models/turnover_period.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/churn_cohort_chart.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/churn_retention_summary.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/inventory_turnover_aging_period_select.dart';

/// Body of the Customer Churn Monitoring widget (Issue #357): the period
/// picker doubles as the merchant-customizable inactivity window.
class ChurnMonitoringBody extends StatefulWidget {
  final List<TransactionEntity> transactions;

  const ChurnMonitoringBody({super.key, required this.transactions});

  @override
  State<ChurnMonitoringBody> createState() => _ChurnMonitoringBodyState();
}

class _ChurnMonitoringBodyState extends State<ChurnMonitoringBody> {
  TurnoverPeriod _period = TurnoverPeriod.last30;

  @override
  Widget build(BuildContext context) {
    final snapshot = ComputeChurnRetentionSnapshot.call(
        widget.transactions, DateTime.now(), _period.duration);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InventoryTurnoverAgingPeriodSelect(
              period: _period,
              onChanged: (p) => setState(() => _period = p ?? _period),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ChurnRetentionSummary(snapshot: snapshot),
        const SizedBox(height: 12),
        ChurnCohortChart(points: snapshot.cohortPoints),
        const SizedBox(height: 8),
        Text(BuildChurnRetentionNarrative.call(snapshot)),
      ],
    );
  }
}
