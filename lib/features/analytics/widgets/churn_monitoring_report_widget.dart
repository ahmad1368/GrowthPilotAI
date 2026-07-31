import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/churn_monitoring_body.dart';

/// Registers the Customer Churn Monitoring & Retention widget (Issue #357)
/// as a pluggable report widget under id `CHURN_MONITORING` (#111).
class ChurnMonitoringReportWidget extends BaseReportWidget {
  const ChurnMonitoringReportWidget(
      {super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    return ChurnMonitoringBody(
        transactions: data['transactions'] as List<TransactionEntity>);
  }
}
