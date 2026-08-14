import 'package:growth_pilot_ai/core/data/entities/anonymized_listing_entity.dart';

/// "Weighting System" (Issue #97 scope item 3): ranks a peer's closeness
/// to the target so the nearest peers can drive #96's percentile more
/// than distant same-category ones. Mirrors the issue's own
/// `calculateRelevance` example (its "condition" field doesn't exist on
/// [AnonymizedListingEntity], so only the location penalty applies here).
class ComputePeerRelevanceScore {
  static int call(AnonymizedListingEntity peer, double targetLat, double targetLng) {
    var score = 100;
    if (peer.generalizedLat != targetLat || peer.generalizedLng != targetLng) {
      score -= 30;
    }
    return score;
  }
}
