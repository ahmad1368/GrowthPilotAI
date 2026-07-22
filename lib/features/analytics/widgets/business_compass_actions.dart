import 'package:flutter/material.dart';

/// AppBar actions for the Business Compass screen: the Issue #114 reorder
/// toggle and the Issue #115 config side-panel opener, extracted so
/// [BusinessCompassScreen] stays within the file-size budget.
class BusinessCompassActions extends StatelessWidget {
  final bool reordering;
  final VoidCallback onToggleReorder;
  final VoidCallback onOpenConfig;

  const BusinessCompassActions({
    super.key,
    required this.reordering,
    required this.onToggleReorder,
    required this.onOpenConfig,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.tune),
          tooltip: 'Configure widgets',
          onPressed: onOpenConfig,
        ),
        IconButton(
          icon: Icon(reordering ? Icons.check : Icons.reorder),
          tooltip: reordering ? 'Done reordering' : 'Reorder widgets',
          onPressed: onToggleReorder,
        ),
      ],
    );
  }
}
