import 'package:growth_pilot_ai/core/data/entities/business_rating_entity.dart';

/// "Anti-Gaming Logic" (Issue #125 AC): flags a suspicious burst of
/// reviews for one business within a short window (e.g. 50 in 1 hour).
class DetectReviewBurst {
  static const defaultThreshold = 50;
  static const defaultWindow = Duration(hours: 1);

  static bool call(
    List<BusinessRatingEntity> ratings,
    String businessId,
    DateTime now, {
    int threshold = defaultThreshold,
    Duration window = defaultWindow,
  }) {
    final cutoff = now.subtract(window);
    final recentCount = ratings
        .where((r) => r.businessId == businessId && r.createdAt.isAfter(cutoff))
        .length;
    return recentCount >= threshold;
  }
}
