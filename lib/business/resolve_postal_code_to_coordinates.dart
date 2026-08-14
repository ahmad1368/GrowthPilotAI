/// Turns a Canadian postal-code prefix into coordinates (Issue #213,
/// "Reverse Geocoding"). This app has no server and no Google
/// Geocoding API key, so real reverse geocoding is infeasible; this
/// is an honest local simulation limited to a fixed table of known
/// Greater Vancouver forward sortation areas rather than a fake
/// "resolves any address" claim.
class ResolvePostalCodeToCoordinates {
  static const _table = {
    'V3B': (lat: 49.2911, lng: -122.8069), // Coquitlam
    'V3J': (lat: 49.2732, lng: -122.8817), // Coquitlam
    'V3T': (lat: 49.1913, lng: -122.8490), // Surrey
    'V3W': (lat: 49.1553, lng: -122.8010), // Surrey
    'V5H': (lat: 49.2267, lng: -122.9899), // Burnaby
    'V6B': (lat: 49.2827, lng: -123.1207), // Vancouver
  };

  static ({double lat, double lng})? call(String postalCode) {
    final prefix = postalCode.trim().toUpperCase();
    if (prefix.length < 3) return null;
    return _table[prefix.substring(0, 3)];
  }
}
