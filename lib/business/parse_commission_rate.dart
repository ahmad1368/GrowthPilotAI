/// Extracts a percentage-format commission rate from a
/// [DescribeCommissionStructure]-formatted audit log value like
/// `"5.0% / \$10000.0"` (Issue #349) — returns null for a fixed-amount
/// structure (`"\$3.0 flat / ..."`) since it has no comparable rate.
class ParseCommissionRate {
  static final _pattern = RegExp(r'^([\d.]+)%');

  static double? call(String description) {
    final match = _pattern.firstMatch(description.trim());
    if (match == null) return null;
    return double.tryParse(match.group(1)!);
  }
}
