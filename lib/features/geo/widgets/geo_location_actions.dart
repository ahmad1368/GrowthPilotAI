import 'package:growth_pilot_ai/business/find_nearby_listings.dart';
import 'package:growth_pilot_ai/business/resolve_postal_code_to_coordinates.dart';
import 'package:growth_pilot_ai/core/data/entities/user_location_preference_entity.dart';
import 'package:growth_pilot_ai/features/geo/widgets/geo_location_repos.dart';

/// Orchestrates setting "My Location" and finding nearby listings
/// (Issue #213). Returns null from [setPostalCode] on an
/// unrecognized postal-code prefix so the UI can show an error.
class GeoLocationActions {
  final GeoLocationRepos repos;
  GeoLocationActions(this.repos);

  UserLocationPreferenceEntity? get currentLocation => repos.location.get();

  UserLocationPreferenceEntity? setPostalCode(String postalCode) {
    final coords = ResolvePostalCodeToCoordinates.call(postalCode);
    if (coords == null) return null;
    repos.location.setLocation(postalCode.trim().toUpperCase(), coords.lat, coords.lng);
    return repos.location.get();
  }

  List<NearbyListing> loadNearby(double radiusKm) {
    final loc = currentLocation;
    if (loc == null) return [];
    return FindNearbyListings.call(repos.listings.getAll(), loc.lat, loc.lng, radiusKm);
  }
}
