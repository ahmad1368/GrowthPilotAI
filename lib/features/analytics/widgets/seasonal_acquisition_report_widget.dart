import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/compute_seasonal_acquisition_impact.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/seasonal_acquisition_view.dart';

/// Registers the Seasonal Discount Acquisition Impact Analyzer
/// (Issue #382) as a pluggable report widget under id
/// `SEASONAL_ACQUISITION_IMPACT` (#111).
class SeasonalAcquisitionReportWidget extends BaseReportWidget {
  const SeasonalAcquisitionReportWidget(
      {super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    final impacts = ComputeSeasonalAcquisitionImpact.call(
        data['transactions'] as List<TransactionEntity>);
    return SeasonalAcquisitionView(impacts: impacts);
  }
}
