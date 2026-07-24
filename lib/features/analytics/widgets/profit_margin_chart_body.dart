import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/compute_profit_margin_series.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/enum/margin_period.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/margin_period_chips.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/profit_margin_chart.dart';

/// Body of the Profit Margin Analysis widget (Issue #350): a local
/// Daily/Weekly/Monthly toggle recomputes [ComputeProfitMarginSeries]
/// on-device — no backend "recalculates at close of business" worker
/// exists in this repo, so the series is derived on demand instead.
class ProfitMarginChartBody extends StatefulWidget {
  final List<TransactionEntity> transactions;

  const ProfitMarginChartBody({super.key, required this.transactions});

  @override
  State<ProfitMarginChartBody> createState() => _ProfitMarginChartBodyState();
}

class _ProfitMarginChartBodyState extends State<ProfitMarginChartBody> {
  var _period = MarginPeriod.monthly;

  @override
  Widget build(BuildContext context) {
    final series = ComputeProfitMarginSeries.call(widget.transactions, _period);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MarginPeriodChips(
          selected: _period,
          onChanged: (p) => setState(() => _period = p),
        ),
        const SizedBox(height: 12),
        ProfitMarginChart(points: series),
      ],
    );
  }
}
