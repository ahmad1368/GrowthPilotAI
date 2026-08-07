import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/accounting_reports_body.dart';

/// Registers the Detailed Accounting Reports engine (Issue #427,
/// acceptance criterion 1) as a pluggable report widget under id
/// `ACCOUNTING_REPORTS_ENGINE` (#111) — no external data needed;
/// [AccountingReportsBody] reads existing commission (#425),
/// fee-waiver (#420), and gateway (#421-423) ledgers itself.
class AccountingReportsReportWidget extends BaseReportWidget {
  const AccountingReportsReportWidget({super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    return const AccountingReportsBody();
  }
}
