import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:growth_pilot_ai/core/models/report_widget_spec.dart';
import 'package:growth_pilot_ai/core/models/widget_layout.dart';
import 'package:growth_pilot_ai/core/widgets/report_widget_registry.dart';

/// Long-press drag-to-reorder edit mode for a [DynamicReportGrid]'s widgets
/// (Issue #114): locked entries render with no drag handle at all, so they
/// can't be picked up or moved by the user.
class ReorderableReportList extends StatelessWidget {
  final List<WidgetLayout> layout;
  final Map<String, ReportWidgetSpec> specsById;
  final void Function(int oldIndex, int newIndex) onReorder;

  const ReorderableReportList({
    super.key,
    required this.layout,
    required this.specsById,
    required this.onReorder,
  });

  @override
  Widget build(BuildContext context) {
    return ReorderableListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      buildDefaultDragHandles: false,
      onReorderStart: (_) => HapticFeedback.mediumImpact(),
      onReorder: onReorder,
      children: [for (var i = 0; i < layout.length; i++) _tile(i)],
    );
  }

  Widget _tile(int index) {
    final entry = layout[index];
    final spec = specsById[entry.widgetId];
    final child = spec == null
        ? const SizedBox.shrink()
        : ReportWidgetRegistry.build(spec);

    return Padding(
      key: ValueKey(entry.widgetId),
      padding: const EdgeInsets.only(bottom: 12),
      child: entry.isLocked
          ? child
          : ReorderableDragStartListener(index: index, child: child),
    );
  }
}
