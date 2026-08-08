import 'package:growth_pilot_ai/business/compute_listing_match_score.dart';
import 'package:growth_pilot_ai/business/is_user_blocked.dart';
import 'package:growth_pilot_ai/core/data/entities/block_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/catalog_listing_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/procurement_request_entity.dart';
import 'package:growth_pilot_ai/core/data/repositories/business_rating_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/kyc_verification_repository.dart';

typedef MatchResult = ({CatalogListingEntity listing, double score});

/// "The Matching Logic Flow" (Issue #145): scores every candidate
/// listing (via [ComputeListingMatchScore]) against a procurement
/// request and returns the top [limit], excluding the requester's own
/// listings and any blocked relationship (#124).
class FindTopMatches {
  static List<MatchResult> call({
    required ProcurementRequestEntity request,
    required List<CatalogListingEntity> candidates,
    required BusinessRatingRepository ratings,
    required KycVerificationRepository kyc,
    required List<BlockEntity> blocks,
    required double globalAverageRating,
    required DateTime now,
    int limit = 10,
  }) {
    final results = <MatchResult>[];
    for (final listing in candidates) {
      if (listing.ownerId == request.requesterId) continue;
      if (IsUserBlocked.call(blocks, request.requesterId, listing.ownerId)) continue;
      final score = ComputeListingMatchScore.call(
          request: request,
          listing: listing,
          ratings: ratings,
          kyc: kyc,
          globalAverageRating: globalAverageRating,
          now: now);
      results.add((listing: listing, score: score));
    }
    results.sort((a, b) => b.score.compareTo(a.score));
    return results.take(limit).toList();
  }
}
