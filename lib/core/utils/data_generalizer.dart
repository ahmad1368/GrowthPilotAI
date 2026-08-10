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

  /// A specific year → its decade (Issue #90), e.g. 1989 → "1980s".
  static String decade(int year) => '${(year ~/ 10) * 10}s';

  /// Snaps a coordinate pair to a grid (Issue #92) — a [step] of 0.005
  /// (~500m) puts every household within a block on the same point, and
  /// the same input always snaps to the same grid center (AC:
  /// "Consistency"). Output is capped at 3 decimal places (AC: "API
  /// never exposes coordinates with more than 3 decimal places").
  static ({double lat, double lng}) generalizeCoordinates(
    double lat,
    double lng, {
    double step = 0.005,
  }) =>
      (lat: _snapToGrid(lat, step), lng: _snapToGrid(lng, step));

  static double _snapToGrid(double value, double step) {
    final snapped = (value / step).round() * step;
    return double.parse(snapped.toStringAsFixed(3));
  }

  /// A timestamp → the start of its UTC hour (Issue #92 AC: rounded
  /// "Created At" timestamps), preventing a minute-level timing attack.
  static DateTime generalizeTimestamp(DateTime date) {
    final utc = date.toUtc();
    return DateTime.utc(utc.year, utc.month, utc.day, utc.hour);
  }
}
