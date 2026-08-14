import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/compute_accounting_summary.dart';
import 'package:growth_pilot_ai/core/models/merchant_accounting_summary.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/accounting_reports_repos.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/accounting_reports_view.dart';

/// Owns the accounting report state (Issue #427) — a manual refresh
/// stands in for live recomputation since this app has no reactive
/// data bus across dashboard widgets.
class AccountingReportsBody extends StatefulWidget {
  const AccountingReportsBody({super.key});
  @override
  State<AccountingReportsBody> createState() => _AccountingReportsBodyState();
}

class _AccountingReportsBodyState extends State<AccountingReportsBody> {
  final _repos = AccountingReportsRepos();
  late List<MerchantAccountingSummary> _summaries = _load();

  List<MerchantAccountingSummary> _load() {
    return ComputeAccountingSummary.call(
      commissionRecords: _repos.commissionRecords.getAll(),
      waiverRecords: _repos.waiverRecords.getAll(),
      gatewayTransactions: _repos.gatewayTransactions.getAll(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AccountingReportsView(
      summaries: _summaries,
      onRefresh: () => setState(() => _summaries = _load()),
    );
  }
}
