import '../../../../objectbox.g.dart';
import '../entities/recommendation_feedback_entity.dart';

/// Insert/lookup CRUD for recommendation feedback (Issue #418),
/// mirroring [WholesaleListingRepository]'s upsert pattern.
class RecommendationFeedbackRepository {
  final Box<RecommendationFeedbackEntity> _box;

  RecommendationFeedbackRepository(this._box);

  int save(RecommendationFeedbackEntity feedback) => _box.put(feedback);

  List<RecommendationFeedbackEntity> getAll() => _box.getAll();

  List<RecommendationFeedbackEntity> forItem(String itemName) => getAll()
      .where((f) => f.itemName.toLowerCase() == itemName.toLowerCase())
      .toList();
}
