/// Best-effort match of the app's 5 import fields to a vendor's own
/// CSV header names (Issue #213, "Mapping Wizard") — case-insensitive
/// exact match; unmatched fields are left null for the user to pick.
class GuessColumnMapping {
  static const fields = ['name', 'sku', 'category', 'industry', 'price'];

  static Map<String, int?> call(List<String> header) {
    final lower = header.map((h) => h.toLowerCase()).toList();
    return {for (final f in fields) f: lower.contains(f) ? lower.indexOf(f) : null};
  }
}
