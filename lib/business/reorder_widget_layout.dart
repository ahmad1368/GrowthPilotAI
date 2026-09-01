import 'package:growth_pilot_ai/core/models/widget_layout.dart';

/// Moves a widget from [oldIndex] to [newIndex] in a [WidgetLayout] list
/// (Issue #114). Refuses the move outright — returns [layout] unchanged —
/// when the dragged widget is locked, since locked (critical-alert)
/// widgets must never be user-repositioned.
class ReorderWidgetLayout {
  static List<WidgetLayout> call(
      List<WidgetLayout> layout, int oldIndex, int newIndex) {
    if (layout[oldIndex].isLocked) return layout;

    final updated = [...layout];
    final moved = updated.removeAt(oldIndex);
    final target = newIndex > oldIndex ? newIndex - 1 : newIndex;
    updated.insert(target, moved);

    return [
      for (var i = 0; i < updated.length; i++)
        updated[i].copyWith(position: i)
    ];
  }
}
