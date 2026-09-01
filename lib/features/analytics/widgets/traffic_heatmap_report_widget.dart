import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/traffic_heatmap_body.dart';

/// Registers the Store Traffic Heatmap widget (Issue #354) as a pluggable
/// report widget under id `TRAFFIC_HEATMAP` (#111).
class TrafficHeatmapReportWidget extends BaseReportWidget {
  const TrafficHeatmapReportWidget(
      {super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    return TrafficHeatmapBody(
        transactions: data['transactions'] as List<TransactionEntity>);
  }
}
