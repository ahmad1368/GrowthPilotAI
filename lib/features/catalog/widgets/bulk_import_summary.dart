import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/import_summary.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// "450 items imported, 12 failed" plus the per-row error log (Issue
/// #141) with a "Copy Error Log" export (Issue #213, "Feedback
/// Loop" — copied via Clipboard, no OS file-save dialog wired up).
class BulkImportSummaryView extends StatelessWidget {
  final ImportSummary? summary;
  final VoidCallback onCopyErrorLog;
  const BulkImportSummaryView({super.key, required this.summary, required this.onCopyErrorLog});

  @override
  Widget build(BuildContext context) {
    final s = summary;
    if (s == null) return const SizedBox.shrink();
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Text('${s.importedCount} imported, ${s.errors.length} failed',
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        if (s.errors.isNotEmpty)
          ShadButton.ghost(onPressed: onCopyErrorLog, child: const Text('Copy Error Log')),
      ]),
      for (final e in s.errors)
        Text('Row ${e.row}: ${e.error}', style: const TextStyle(fontSize: 12, color: Colors.red)),
    ]);
  }
}
