import '../../../../objectbox.g.dart';
import '../entities/review_feedback_entity.dart';

/// Basic CRUD for logged customer reviews (Issue #358), mirroring
/// [CsatRatingRepository]'s insert/getAll pattern.
class ReviewFeedbackRepository {
  final Box<ReviewFeedbackEntity> _box;

  ReviewFeedbackRepository(this._box);

  int insert(ReviewFeedbackEntity review) => _box.put(review);

  List<ReviewFeedbackEntity> getAll() => _box.getAll();
}
