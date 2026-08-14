import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/revenue_dependency_body.dart';

/// Registers the Revenue Dependency on Loyal Customers Evaluator
/// (Issue #376) as a pluggable report widget under id
/// `REVENUE_DEPENDENCY` (#111).
class RevenueDependencyReportWidget extends BaseReportWidget {
  const RevenueDependencyReportWidget(
      {super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    return RevenueDependencyBody(
        transactions: data['transactions'] as List<TransactionEntity>);
  }
}
