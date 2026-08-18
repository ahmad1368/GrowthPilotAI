import 'package:flutter/material.dart';

/// One pinned header cell (goal title or requirement code+description)
/// in the [TraceabilityMatrixGrid] (Issue #239) — highlighted when it
/// has a Gap Analysis flag.
class TraceabilityMatrixHeaderCell extends StatelessWidget {
  final String label;
  final Color? gapColor;

  const TraceabilityMatrixHeaderCell({super.key, required this.label, this.gapColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: gapColor?.withValues(alpha: 0.2),
      padding: const EdgeInsets.all(4),
      alignment: Alignment.centerLeft,
      child: Text(label, maxLines: 2, overflow: TextOverflow.ellipsis),
    );
  }
}
