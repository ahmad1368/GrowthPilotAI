import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/compute_financial_health.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/core/data/entities/linked_account_entity.dart';
import 'package:growth_pilot_ai/core/utils/currency_format.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/financial_health_score_badge.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/financial_health_stat_row.dart';

/// Registers the Financial Health & Asset Liquidity widget (Issue #385) as
/// a pluggable report widget under id `FINANCIAL_HEALTH` (#111).
class FinancialHealthReportWidget extends BaseReportWidget {
  const FinancialHealthReportWidget(
      {super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    final accounts = data['accounts'] as List<LinkedAccountEntity>;
    if (accounts.isEmpty) {
      return const Text('No linked accounts yet.');
    }
    final health = ComputeFinancialHealth.call(accounts);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FinancialHealthScoreBadge(score: health.healthScore),
        const SizedBox(height: 12),
        FinancialHealthStatRow(
            label: 'Current Assets', value: CurrencyFormat.cad(health.currentAssets)),
        FinancialHealthStatRow(
            label: 'Current Liabilities', value: CurrencyFormat.cad(health.currentLiabilities)),
        FinancialHealthStatRow(
            label: 'Working Capital', value: CurrencyFormat.cad(health.workingCapital)),
        FinancialHealthStatRow(
            label: 'Current Ratio', value: health.currentRatio.toStringAsFixed(2)),
      ],
    );
  }
}
