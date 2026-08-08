import 'package:growth_pilot_ai/business/compute_availability_score.dart';
import 'package:growth_pilot_ai/business/compute_business_trust_score.dart';
import 'package:growth_pilot_ai/business/compute_distance_km.dart';
import 'package:growth_pilot_ai/business/compute_geo_proximity_score.dart';
import 'package:growth_pilot_ai/business/compute_match_confidence_score.dart';
import 'package:growth_pilot_ai/business/compute_reputation_score.dart';
import 'package:growth_pilot_ai/business/compute_semantic_similarity.dart';
import 'package:growth_pilot_ai/core/data/entities/catalog_listing_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/procurement_request_entity.dart';
import 'package:growth_pilot_ai/core/data/repositories/business_rating_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/kyc_verification_repository.dart';

/// One listing's full match score against a request (Issue #145) —
/// pulled out of [FindTopMatches] to stay under the 50-line file limit.
class ComputeListingMatchScore {
  static double call({
    required ProcurementRequestEntity request,
    required CatalogListingEntity listing,
    required BusinessRatingRepository ratings,
    required KycVerificationRepository kyc,
    required double globalAverageRating,
    required DateTime now,
  }) {
    final bayesianRating = ComputeBusinessTrustScore.call(
        ratings: ratings.getForBusiness(listing.ownerId), globalAverage: globalAverageRating, now: now);
    final distanceKm = ComputeDistanceKm.call(
        request.centerLat, request.centerLng, listing.locationLat, listing.locationLng);

    return ComputeMatchConfidenceScore.call(
      semanticSimilarity: ComputeSemanticSimilarity.call('${request.sector} ${request.summary}',
          '${listing.sector} ${listing.title} ${listing.description}'),
      geoProximityScore: ComputeGeoProximityScore.call(distanceKm),
      reputationScore: ComputeReputationScore.call(
          bayesianRating: bayesianRating,
          isKycVerified: kyc.getForUser(listing.ownerId)?.isVerified ?? false),
      availabilityScore: ComputeAvailabilityScore.call(listing.availability),
    );
  }
}
