import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/report_widget_spec.dart';

/// Dropdown to pick which configurable widget the side-panel edits (Issue
/// #115), split out of [WidgetConfigEditor] to keep it under budget.
class WidgetConfigSelector extends StatelessWidget {
  final List<ReportWidgetSpec> options;
  final String selectedId;
  final ValueChanged<String?> onChanged;

  const WidgetConfigSelector({
    super.key,
    required this.options,
    required this.selectedId,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: selectedId,
      isExpanded: true,
      items: [
        for (final s in options)
          DropdownMenuItem(value: s.id, child: Text(s.title)),
      ],
      onChanged: onChanged,
    );
  }
}
