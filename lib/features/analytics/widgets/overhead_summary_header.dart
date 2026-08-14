import 'package:flutter/material.dart';

/// Total overhead-to-revenue ratio stat shown above the category list
/// (Issue #367).
class OverheadSummaryHeader extends StatelessWidget {
  final double totalRatio;

  const OverheadSummaryHeader({super.key, required this.totalRatio});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Expanded(
            child: Text('Total Overhead vs. Revenue',
                overflow: TextOverflow.ellipsis,
                style:
                    TextStyle(color: scheme.onSurface.withValues(alpha: 0.7))),
          ),
          Text(
            '${(totalRatio * 100).toStringAsFixed(1)}%',
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
