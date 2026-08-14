import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/micro_credit_body.dart';

/// Registers the Internal Short-Term Micro-Credit and Working
/// Capital Facility (Issue #419) as a pluggable report widget under
/// id `MICRO_CREDIT_FACILITY` (#111).
class MicroCreditReportWidget extends BaseReportWidget {
  const MicroCreditReportWidget({super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    return MicroCreditBody(transactions: data['transactions'] as List<TransactionEntity>);
  }
}
