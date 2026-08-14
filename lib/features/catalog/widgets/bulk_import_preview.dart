import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/dry_run_import_rows.dart';

/// Shows each row's dry-run validation status — green if it will be
/// imported, red with the specific error if not (Issue #213,
/// "Dry-Run Preview").
class BulkImportPreview extends StatelessWidget {
  final List<DryRunRowResult> results;
  const BulkImportPreview({super.key, required this.results});

  @override
  Widget build(BuildContext context) {
    if (results.isEmpty) return const SizedBox.shrink();
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('Preview:', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
      for (final r in results)
        Text(
          r.valid ? 'Row ${r.row}: OK' : 'Row ${r.row}: ${r.error}',
          style: TextStyle(fontSize: 12, color: r.valid ? Colors.green : Colors.red),
        ),
    ]);
  }
}
