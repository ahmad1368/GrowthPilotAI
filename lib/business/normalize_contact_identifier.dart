/// Normalizes a raw phone number or email before hashing (Issue #541,
/// acceptance criterion 2) — so the same contact typed with different
/// spacing/casing still hashes identically.
class NormalizeContactIdentifier {
  static String call(String raw) {
    final trimmed = raw.trim().toLowerCase();
    if (trimmed.contains('@')) return trimmed;
    return trimmed.replaceAll(RegExp(r'[\s\-\(\)]'), '');
  }
}
