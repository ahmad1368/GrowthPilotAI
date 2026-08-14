import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/build_affordability_recommendation.dart';
import 'package:growth_pilot_ai/business/compute_regional_affordability.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/utils/currency_format.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/affordability_index_badge.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/financial_health_stat_row.dart';

/// Registers the Target Region Purchasing Power Fit widget (Issue #397) as
/// a pluggable report widget under id `REGIONAL_AFFORDABILITY` (#111).
class RegionalAffordabilityReportWidget extends BaseReportWidget {
  const RegionalAffordabilityReportWidget(
      {super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    final transactions = data['transactions'] as List<TransactionEntity>;
    if (transactions.isEmpty) {
      return const Text('No transactions yet to compare against regional pricing.');
    }
    final result = ComputeRegionalAffordability.call(transactions);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AffordabilityIndexBadge(result: result),
        const SizedBox(height: 12),
        FinancialHealthStatRow(
            label: 'Average Basket Price', value: CurrencyFormat.cad(result.averageBasketPrice)),
        FinancialHealthStatRow(
            label: 'Regional Median Monthly Income',
            value: CurrencyFormat.cad(result.medianMonthlyIncome)),
        const SizedBox(height: 8),
        Text(BuildAffordabilityRecommendation.call(result),
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.8))),
      ],
    );
  }
}
