import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/import_progress.dart';

/// The progress indicator shown while a bulk import runs (Issue
/// #217) — stage name, percentage, and a real measured ETA (often
/// near-zero for this app's small local demo datasets — that's
/// honest, not a fabricated slow-motion simulation).
class BulkImportProgressBar extends StatelessWidget {
  final ImportProgress? progress;
  const BulkImportProgressBar({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    final p = progress;
    if (p == null) return const SizedBox.shrink();
    final percent = p.total == 0 ? 0.0 : p.current / p.total;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('${p.stage}: row ${p.current} of ${p.total} — ETA ${p.etaSeconds.toStringAsFixed(1)}s',
          style: const TextStyle(fontSize: 12)),
      LinearProgressIndicator(value: percent),
    ]);
  }
}
