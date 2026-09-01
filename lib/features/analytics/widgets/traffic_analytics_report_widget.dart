import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/core/data/entities/traffic_count_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/traffic_analytics_body.dart';

/// Registers the Foot and Vehicular Traffic Analytics Report (Issue
/// #381) as a pluggable report widget under id
/// `FOOT_VEHICLE_TRAFFIC_ANALYTICS` (#111).
class TrafficAnalyticsReportWidget extends BaseReportWidget {
  const TrafficAnalyticsReportWidget(
      {super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    return TrafficAnalyticsBody(
      initialCounts: data['counts'] as List<TrafficCountEntity>,
      transactions: data['transactions'] as List<TransactionEntity>,
    );
  }
}
