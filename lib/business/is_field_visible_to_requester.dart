import 'package:growth_pilot_ai/core/enum/field_visibility.dart';

/// "Data Filtering Workflow" decision (Issue #218) — a public field is
/// always visible; a private field is visible only to an approved
/// connection. This is a client-side-only check (see PR notes: this repo
/// has no backend to enforce redaction before data leaves a server, so it
/// cannot satisfy the issue's "Zero Data Leakage" AC on its own).
class IsFieldVisibleToRequester {
  static bool call(FieldVisibility visibility, bool isApprovedConnection) {
    return visibility == FieldVisibility.public || isApprovedConnection;
  }
}
