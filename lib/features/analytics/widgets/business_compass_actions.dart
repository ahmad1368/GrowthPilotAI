import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/widgets/dashboard_export_button.dart';

/// AppBar actions for the Business Compass screen: the Issue #114 reorder
/// toggle, the Issue #115 config side-panel opener, and the Issue #117
/// export menu, extracted so [BusinessCompassScreen] stays within the
/// file-size budget.
class BusinessCompassActions extends StatelessWidget {
  final bool reordering;
  final VoidCallback onToggleReorder;
  final VoidCallback onOpenConfig;
  final GlobalKey canvasKey;

  const BusinessCompassActions({
    super.key,
    required this.reordering,
    required this.onToggleReorder,
    required this.onOpenConfig,
    required this.canvasKey,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (!reordering)
          DashboardExportButton(canvasKey: canvasKey, title: 'Business Compass'),
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
