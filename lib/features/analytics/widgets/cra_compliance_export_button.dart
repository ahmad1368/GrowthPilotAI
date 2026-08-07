import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/export_cra_compliance_report_csv.dart';
import 'package:growth_pilot_ai/core/models/cra_compliance_row.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// "Export as CSV" action for the CRA compliance report (Issue #428,
/// acceptance criterion 2), mirroring [AccountingReportsExportButton]
/// (#427).
class CraComplianceExportButton extends StatefulWidget {
  final List<CraComplianceRow> rows;
  const CraComplianceExportButton({super.key, required this.rows});

  @override
  State<CraComplianceExportButton> createState() => _CraComplianceExportButtonState();
}

class _CraComplianceExportButtonState extends State<CraComplianceExportButton> {
  bool _isExporting = false;

  Future<void> _export() async {
    setState(() => _isExporting = true);
    try {
      await ExportCraComplianceReportCsv.call(widget.rows, 'CRA Compliance Report');
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
