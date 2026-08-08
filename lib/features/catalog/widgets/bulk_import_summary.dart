import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/import_summary.dart';

/// "450 items imported, 12 failed" plus the per-row error log (Issue
/// #141, acceptance criteria "Success summary" and "Download Error
/// Log" — shown inline instead of a downloadable file).
class BulkImportSummaryView extends StatelessWidget {
  final ImportSummary? summary;
  const BulkImportSummaryView({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    final s = summary;
    if (s == null) return const SizedBox.shrink();
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('${s.importedCount} imported, ${s.errors.length} failed',
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
      for (final e in s.errors)
        Text('Row ${e.row}: ${e.error}', style: const TextStyle(fontSize: 12, color: Colors.red)),
    ]);
  }
}
