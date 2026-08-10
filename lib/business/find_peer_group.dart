import 'package:growth_pilot_ai/core/data/entities/anonymized_listing_entity.dart';
import 'package:growth_pilot_ai/core/enum/peer_group_scope.dart';
import 'package:growth_pilot_ai/core/models/peer_group_result.dart';

/// The "Waterfall" peer selection algorithm (Issue #97): tries the exact
/// generalized grid cell first, then zooms out to a coarser grid bucket,
/// then drops location entirely — stopping at the first stage with at
/// least [k] members (AC: "never returns a group with fewer than k").
/// Falls back to "Insufficient Data" rather than breaking privacy if even
/// the broadest scope is too small.
class FindPeerGroup {
  static PeerGroupResult call(
    List<AnonymizedListingEntity> allListings,
    String category,
    double lat,
    double lng, {
    int k = 5,
    double cityGridStep = 0.05,
  }) {
    final neighborhood = allListings
        .where((l) =>
            l.category == category && l.generalizedLat == lat && l.generalizedLng == lng)
        .toList();
    if (neighborhood.length >= k) {
      return PeerGroupResult(peers: neighborhood, scope: PeerGroupScope.neighborhood);
    }

    final cityLat = _snapToCoarseGrid(lat, cityGridStep);
    final cityLng = _snapToCoarseGrid(lng, cityGridStep);
    final city = allListings
        .where((l) =>
            l.category == category &&
            _snapToCoarseGrid(l.generalizedLat, cityGridStep) == cityLat &&
            _snapToCoarseGrid(l.generalizedLng, cityGridStep) == cityLng)
        .toList();
    if (city.length >= k) {
      return PeerGroupResult(peers: city, scope: PeerGroupScope.city);
    }

    final regional = allListings.where((l) => l.category == category).toList();
    if (regional.length >= k) {
      return PeerGroupResult(peers: regional, scope: PeerGroupScope.regional);
    }

    return const PeerGroupResult(peers: [], scope: null);
  }

  static double _snapToCoarseGrid(double value, double step) => (value / step).round() * step;
}
