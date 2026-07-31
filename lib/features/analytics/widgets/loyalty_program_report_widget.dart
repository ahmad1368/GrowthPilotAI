import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/loyalty_program_body.dart';

/// Registers the Loyalty Program Effectiveness Evaluator (Issue #396) as
/// a pluggable report widget under id `LOYALTY_PROGRAM_EFFECTIVENESS`
/// (#111).
class LoyaltyProgramReportWidget extends BaseReportWidget {
  const LoyaltyProgramReportWidget(
      {super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    return LoyaltyProgramBody(
        transactions: data['transactions'] as List<TransactionEntity>);
  }
}
