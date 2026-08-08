import 'package:flutter/material.dart';

/// Shows the parsed CSV rows before final submission (Issue #141,
/// acceptance criterion "Preview Step").
class BulkImportPreview extends StatelessWidget {
  final List<List<String>> rows;
  const BulkImportPreview({super.key, required this.rows});

  @override
  Widget build(BuildContext context) {
    if (rows.isEmpty) return const SizedBox.shrink();
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('Preview:', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
      for (final row in rows) Text(row.join(' | '), style: const TextStyle(fontSize: 12)),
    ]);
  }
}
