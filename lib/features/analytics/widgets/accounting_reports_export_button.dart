import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/export_accounting_report_csv.dart';
import 'package:growth_pilot_ai/core/models/merchant_accounting_summary.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// "Export as CSV" action for the accounting report (Issue #427,
/// acceptance criterion 1), mirroring
/// [InventoryValuationExportButton] (#446).
class AccountingReportsExportButton extends StatefulWidget {
  final List<MerchantAccountingSummary> summaries;
  const AccountingReportsExportButton({super.key, required this.summaries});

  @override
  State<AccountingReportsExportButton> createState() => _AccountingReportsExportButtonState();
}

class _AccountingReportsExportButtonState extends State<AccountingReportsExportButton> {
  bool _isExporting = false;

  Future<void> _export() async {
    setState(() => _isExporting = true);
    try {
      await ExportAccountingReportCsv.call(widget.summaries, 'Accounting Report');
    } finally {
      if (mounted) setState(() => _isExporting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isExporting) {
      return const Padding(
        padding: EdgeInsets.all(8),
        child: SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2)),
      );
    }
    return ShadButton.ghost(onPressed: _export, child: const Text('Export as CSV'));
  }
}
