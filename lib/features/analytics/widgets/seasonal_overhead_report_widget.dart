import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/build_seasonal_overhead_narrative.dart';
import 'package:growth_pilot_ai/business/compute_seasonal_overhead.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/seasonal_overhead_chart.dart';

/// Registers the Seasonal Energy & Maintenance Cost widget (Issue #386) as
/// a pluggable report widget under id `SEASONAL_OVERHEAD_CHART` (#111): a
/// month-of-year average expense from local history plus a one-line
/// budgeting prompt for the peak-cost month — not the issue's literal
/// HVAC/equipment-sensor-driven efficiency engine, which this repo has no
/// data or backend to support.
class SeasonalOverheadReportWidget extends BaseReportWidget {
  const SeasonalOverheadReportWidget(
      {super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    final points = ComputeSeasonalOverhead.call(
        data['transactions'] as List<TransactionEntity>);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SeasonalOverheadChart(points: points),
        const SizedBox(height: 8),
        Text(BuildSeasonalOverheadNarrative.call(points)),
      ],
    );
  }
}
