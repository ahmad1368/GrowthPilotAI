import 'package:objectbox/objectbox.dart';
import 'package:growth_pilot_ai/core/enum/recommendation_type.dart';

/// One sent Smart Recommendation (Issue #75) — backs [CapRecommendationFrequency]'s
/// 7-day send history and the "Conversion Rate" acceptance criterion
/// ([actedOn] flips true when the user taps the card's action button
/// rather than dismissing/snoozing it).
@Entity()
class RecommendationLogEntity {
  @Id()
  int id = 0;

  int dbType; // RecommendationType index
  @Index()
  DateTime sentAt;
  bool actedOn;

  RecommendationLogEntity({
    this.id = 0,
    required this.dbType,
    required this.sentAt,
    this.actedOn = false,
  });

  RecommendationType get type => RecommendationType.values[dbType];
}
