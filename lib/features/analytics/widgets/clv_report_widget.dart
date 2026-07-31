import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/clv_body.dart';

/// Registers the Customer Lifetime Value Analytics Engine (Issue #394) as
/// a pluggable report widget under id `CLV_ANALYTICS` (#111).
class ClvReportWidget extends BaseReportWidget {
  const ClvReportWidget({super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    return ClvBody(transactions: data['transactions'] as List<TransactionEntity>);
  }
}
