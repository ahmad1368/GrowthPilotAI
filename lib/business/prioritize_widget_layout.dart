import 'package:growth_pilot_ai/core/models/widget_layout.dart';

/// Floats locked ("critical alert") widgets to the front of the layout,
/// preserving their relative order, regardless of any saved or user
/// ordering (Issue #114's "Priority Override" requirement).
class PrioritizeWidgetLayout {
  static List<WidgetLayout> call(List<WidgetLayout> layout) {
    final locked = layout.where((w) => w.isLocked);
    final unlocked = layout.where((w) => !w.isLocked);
    final ordered = [...locked, ...unlocked];

    return [
      for (var i = 0; i < ordered.length; i++)
        ordered[i].copyWith(position: i)
    ];
  }
}
