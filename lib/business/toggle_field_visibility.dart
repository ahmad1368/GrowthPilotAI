import 'package:growth_pilot_ai/core/enum/field_visibility.dart';

/// Flips a contact field between public/private (Issue #218's "Inline
/// Indicators... tapping the icon toggles the visibility status
/// immediately").
class ToggleFieldVisibility {
  static FieldVisibility call(FieldVisibility current) {
    return current == FieldVisibility.public ? FieldVisibility.private : FieldVisibility.public;
  }
}
