import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/visitor_count_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/conversion_rate_body.dart';

/// Registers the Visitor-to-Buyer Conversion Rate Tracker (Issue #387)
/// as a pluggable report widget under id `VISITOR_CONVERSION_RATE`
/// (#111).
class ConversionRateReportWidget extends BaseReportWidget {
  const ConversionRateReportWidget(
      {super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    return ConversionRateBody(
      initialCounts: data['counts'] as List<VisitorCountEntity>,
      transactions: data['transactions'] as List<TransactionEntity>,
    );
  }
}
