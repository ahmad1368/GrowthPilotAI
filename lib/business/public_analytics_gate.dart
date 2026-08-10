import 'package:growth_pilot_ai/business/apply_k_anonymity.dart';
import 'package:growth_pilot_ai/core/data/entities/anonymized_listing_entity.dart';

/// "Data in the analytics store satisfies k-anonymity before being
/// accessible by the public API" (Issue #93 AC) — the read-time gate in
/// front of the decoupled store, reusing #90's suppression algorithm
/// grouped by the generalized location+age fields #92/#90 already
/// produced.
class PublicAnalyticsGate {
  static List<AnonymizedListingEntity> filter(
    List<AnonymizedListingEntity> listings, {
    int k = 5,
  }) {
    return ApplyKAnonymity.call<AnonymizedListingEntity>(
      listings,
      (l) => '${l.generalizedLat}-${l.generalizedLng}-${l.generalAge}',
      k: k,
    ).data;
  }
}
