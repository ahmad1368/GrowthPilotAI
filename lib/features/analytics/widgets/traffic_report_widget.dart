import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/traffic_report_body.dart';

/// Registers the Peak Hours Customer Traffic widget (Issue #365) as a
/// pluggable report widget under id `TRAFFIC_ANALYSIS` (#111).
class TrafficReportWidget extends BaseReportWidget {
  const TrafficReportWidget(
      {super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    return TrafficReportBody(
        transactions: data['transactions'] as List<TransactionEntity>);
  }
}
