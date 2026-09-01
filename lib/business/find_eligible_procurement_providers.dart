import 'package:growth_pilot_ai/business/compute_business_trust_score.dart';
import 'package:growth_pilot_ai/business/filter_listings_within_radius.dart';
import 'package:growth_pilot_ai/business/is_user_blocked.dart';
import 'package:growth_pilot_ai/core/data/entities/procurement_request_entity.dart';
import 'package:growth_pilot_ai/core/data/repositories/block_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/business_rating_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/catalog_listing_repository.dart';

/// "Broadcast Logic" (Issue #126): sector + geo-radius match against
/// catalog listings (#121/#138), then excludes Blocked relations (#124)
/// and providers below the "minRating: 4.0" threshold (#125).
class FindEligibleProcurementProviders {
  static const minRating = 4.0;

  static List<String> call({
    required ProcurementRequestEntity request,
    required CatalogListingRepository listings,
    required BlockRepository blocks,
    required BusinessRatingRepository ratings,
    required double globalAverageRating,
    required DateTime now,
  }) {
    final sectorMatches = listings.getAll().where((l) => l.sector == request.sector).toList();
    final nearby = FilterListingsWithinRadius.call(
        sectorMatches, request.centerLat, request.centerLng, request.radiusKm);
    final candidateIds = nearby.map((l) => l.ownerId).toSet();
    final blockList = blocks.getAll();

    return candidateIds.where((providerId) {
      if (IsUserBlocked.call(blockList, request.requesterId, providerId)) return false;
      final trustScore = ComputeBusinessTrustScore.call(
          ratings: ratings.getForBusiness(providerId), globalAverage: globalAverageRating, now: now);
      return trustScore >= minRating;
    }).toList();
  }
}
