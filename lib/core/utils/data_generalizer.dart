/// Generalizes indirect identifiers so records stay analytically useful but no
/// longer pinpoint an individual: dates → month, postal codes → 3-char FSA.
class DataGeneralizer {
  /// Specific date → "YYYY-MM" (drops the exact day).
  static String monthPeriod(DateTime date) {
    final utc = date.toUtc();
    return '${utc.year}-${utc.month.toString().padLeft(2, '0')}';
  }

  /// Canadian postal code → Forward Sortation Area (first 3 chars, e.g. "V3J").
  static String forwardSortationArea(String? postalCode) {
    if (postalCode == null) return '';
    final cleaned = postalCode.replaceAll(' ', '').toUpperCase();
    return cleaned.length >= 3 ? cleaned.substring(0, 3) : cleaned;
  }
}
