import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/build_consumer_behavior_recommendation.dart';
import 'package:growth_pilot_ai/business/compute_consumer_behavior_segments.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/utils/currency_format.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/financial_health_stat_row.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/low_income_fit_badge.dart';

/// Registers the Consumer Behavior & Low-Income Demographic Analysis
/// widget (Issue #353) as a pluggable report widget under id
/// `CONSUMER_BEHAVIOR_SEGMENTS` (#111).
class ConsumerBehaviorReportWidget extends BaseReportWidget {
  const ConsumerBehaviorReportWidget(
      {super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    final transactions = data['transactions'] as List<TransactionEntity>;
    if (transactions.isEmpty) {
      return const Text('No transactions yet to segment consumer behavior.');
    }
    final insight = ComputeConsumerBehaviorSegments.call(transactions);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LowIncomeFitBadge(insight: insight),
        const SizedBox(height: 12),
        FinancialHealthStatRow(
            label: 'Average Basket Size',
            value: CurrencyFormat.cad(insight.averageBasketSize)),
        FinancialHealthStatRow(
            label: 'Visit Frequency',
            value: '${insight.visitFrequencyPerWeek.toStringAsFixed(1)}/week'),
        const SizedBox(height: 8),
        Text(BuildConsumerBehaviorRecommendation.call(insight),
            style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.8))),
      ],
    );
  }
}
