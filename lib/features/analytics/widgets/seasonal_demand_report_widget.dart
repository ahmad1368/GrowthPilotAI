import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/build_seasonal_demand_narrative.dart';
import 'package:growth_pilot_ai/business/compute_seasonal_demand.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/seasonal_demand_chart.dart';

/// Registers the Seasonal Demand Prediction widget (Issue #352) as a
/// pluggable report widget under id `SEASONAL_DEMAND_CHART` (#111): a
/// month-of-year average from local history plus a one-line staffing/
/// inventory prompt for the peak month — not the issue's literal
/// weather/holiday-correlated ML model, which this repo has no data or
/// backend to support.
class SeasonalDemandReportWidget extends BaseReportWidget {
  const SeasonalDemandReportWidget(
      {super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    final points = ComputeSeasonalDemand.call(
        data['transactions'] as List<TransactionEntity>);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SeasonalDemandChart(points: points),
        const SizedBox(height: 8),
        Text(BuildSeasonalDemandNarrative.call(points)),
      ],
    );
  }
}
