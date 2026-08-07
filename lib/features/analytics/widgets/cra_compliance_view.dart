import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/cra_compliance_row.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/cra_compliance_export_button.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/cra_compliance_log_row.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Renders the CRA compliance ledger plus sync/export controls
/// (Issue #428, acceptance criteria 1-2). Purely presentational.
class CraComplianceView extends StatelessWidget {
  final List<CraComplianceRow> rows;
  final Future<void> Function() onSync;
  const CraComplianceView({super.key, required this.rows, required this.onSync});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          ShadButton.ghost(onPressed: onSync, child: const Text('Sync Compliance Log')),
          CraComplianceExportButton(rows: rows),
        ]),
        if (rows.isEmpty)
          const Text(
            'No settled transactions logged yet — sync to capture settled '
            'banking/crypto transactions for CRA record-keeping.',
            style: TextStyle(fontSize: 12),
          )
        else
          for (final row in rows) CraComplianceLogRow(row: row),
      ],
    );
  }
}
