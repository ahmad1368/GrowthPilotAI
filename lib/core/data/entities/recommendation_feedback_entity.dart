import 'package:objectbox/objectbox.dart';
import 'package:growth_pilot_ai/core/enum/recommendation_feedback_status.dart';

/// One accept/dismiss response to a restocking recommendation (Issue
/// #418, acceptance criterion 4) — this app has no real ML training
/// pipeline, so "continuous model retraining" is this feedback log
/// feeding [ComputeRecommendationConfidence]'s accept-rate heuristic
/// instead of an actual retrained model.
@Entity()
class RecommendationFeedbackEntity {
  @Id()
  int id = 0;

  @Index()
  String itemName;

  int dbStatus; // RecommendationFeedbackStatus index

  @Property(type: PropertyType.date)
  DateTime recordedAt;

  RecommendationFeedbackEntity({
    this.id = 0,
    required this.itemName,
    required this.dbStatus,
    required this.recordedAt,
  });

  RecommendationFeedbackStatus get status => RecommendationFeedbackStatus.values[dbStatus];
  set status(RecommendationFeedbackStatus value) => dbStatus = value.index;
}
