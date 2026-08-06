import 'package:flutter/material.dart';

/// Dynamic progress bar toward a campaign's volume threshold (Issue
/// #414, acceptance criterion 2) — split out of [GroupPurchaseRow] to
/// stay under the file line cap.
class GroupPurchaseProgressBar extends StatelessWidget {
  final double percent;

  const GroupPurchaseProgressBar({super.key, required this.percent});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: LinearProgressIndicator(
        value: percent,
        minHeight: 6,
        backgroundColor: scheme.onSurface.withValues(alpha: 0.1),
      ),
    );
  }
}
