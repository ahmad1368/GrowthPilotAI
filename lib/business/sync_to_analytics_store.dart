import 'package:growth_pilot_ai/business/compute_analytics_retention_expiry.dart';
import 'package:growth_pilot_ai/business/generate_deterministic_hash.dart';
import 'package:growth_pilot_ai/core/data/entities/anonymized_listing_entity.dart';
import 'package:growth_pilot_ai/core/models/hash_pepper.dart';
import 'package:growth_pilot_ai/core/utils/data_generalizer.dart';

/// The "Firewall" (Issue #93): builds a shadow record for the decoupled
/// analytics store from raw fields, composing #89's hashing, #90's age
/// generalization, and #92's coordinate/timestamp generalization — no
/// raw id, exact coordinates, or exact birth year ever reach the
/// returned entity (AC: "No raw latitude or longitude values exist").
/// Pure: the caller is responsible for persisting the result via
/// [AnonymizedListingRepository].
class SyncToAnalyticsStore {
  static AnonymizedListingEntity call({
    required String rawId,
    required double lat,
    required double lng,
    required String category,
    required int approximateAgeYear,
    required DateTime createdAt,
    required HashPepper pepper,
  }) {
    final location = DataGeneralizer.generalizeCoordinates(lat, lng);
    final recordedAt = DataGeneralizer.generalizeTimestamp(createdAt);
    return AnonymizedListingEntity(
      hashedId: GenerateDeterministicHash.call(rawId, pepper),
      generalizedLat: location.lat,
      generalizedLng: location.lng,
      category: category,
      generalAge: DataGeneralizer.decade(approximateAgeYear),
      recordedAt: recordedAt,
      expireAt: ComputeAnalyticsRetentionExpiry.call(recordedAt),
    );
  }
}
