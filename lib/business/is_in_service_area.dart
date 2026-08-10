/// "Geographic Sanitization" (Issue #98 scope item 2): the BC Lower
/// Mainland bounding box, mirroring the issue's own `isInServiceArea`.
class IsInServiceArea {
  static const minLat = 49.00;
  static const maxLat = 49.35;
  static const minLng = -123.30;
  static const maxLng = -122.50;

  static bool call(double lat, double lng) =>
      lat >= minLat && lat <= maxLat && lng >= minLng && lng <= maxLng;
}
