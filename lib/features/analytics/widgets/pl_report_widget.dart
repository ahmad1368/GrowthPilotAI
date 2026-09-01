import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/pl_report_body.dart';

/// Registers the Itemized Financial Reporting / P&L widget (Issue #355) as
/// a pluggable report widget under id `PL_REPORT` (#111).
class PLReportWidget extends BaseReportWidget {
  const PLReportWidget({super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    return PLReportBody(
        transactions: data['transactions'] as List<TransactionEntity>);
  }
}
