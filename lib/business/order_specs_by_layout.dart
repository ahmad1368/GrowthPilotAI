import 'package:growth_pilot_ai/core/models/report_widget_spec.dart';
import 'package:growth_pilot_ai/core/models/widget_layout.dart';

/// Reorders a list of [ReportWidgetSpec]s to match a saved [WidgetLayout]
/// order (Issue #114). Specs with no matching layout entry are dropped
/// rather than crashing — the layout may be stale after a widget is
/// removed from the registry.
class OrderSpecsByLayout {
  static List<ReportWidgetSpec> call(
      List<ReportWidgetSpec> specs, List<WidgetLayout> layout) {
    final specsById = {for (final s in specs) s.id: s};
    return [
      for (final entry in layout)
        if (specsById.containsKey(entry.widgetId)) specsById[entry.widgetId]!
    ];
  }
}
