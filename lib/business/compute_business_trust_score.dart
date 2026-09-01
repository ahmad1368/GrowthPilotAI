import 'package:growth_pilot_ai/business/apply_rating_time_decay.dart';
import 'package:growth_pilot_ai/business/compute_business_rating_average.dart';
import 'package:growth_pilot_ai/business/compute_weighted_business_rating.dart';
import 'package:growth_pilot_ai/core/data/entities/business_rating_entity.dart';

/// The full "Weighted Trust Pipeline" (Issue #125): decay each review by
/// its age, then Bayesian-weight the decayed average against the
/// platform-wide [globalAverage] so a handful of reviews can't outrank
/// an established track record.
class ComputeBusinessTrustScore {
  static double call({
    required List<BusinessRatingEntity> ratings,
    required double globalAverage,
    required DateTime now,
    int minReviews = 5,
  }) {
    if (ratings.isEmpty) return globalAverage;

    final decayedScores = ratings.map((r) => ApplyRatingTimeDecay.call(
        r.createdAt, ComputeBusinessRatingAverage.call(r), now));
    final decayedAverage = decayedScores.reduce((a, b) => a + b) / ratings.length;

    return ComputeWeightedBusinessRating.call(
      reviewCount: ratings.length,
      averageRating: decayedAverage,
      globalAverage: globalAverage,
      minReviews: minReviews,
    );
  }
}
