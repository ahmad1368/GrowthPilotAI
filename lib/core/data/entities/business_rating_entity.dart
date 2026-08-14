import 'package:objectbox/objectbox.dart';

/// One submitted rating of a business (Issue #125) — the "Multi-
/// Dimensional Metrics" sub-scores are the three named in the issue's
/// own scope ("Punctuality," "Accuracy," "Communication"), each on a
/// 1-5 scale. [isVerified] mirrors a confirmed interaction between the
/// rater and business — locally, "confirmed" means an existing
/// [ChatRoomEntity] between them, since the Matching Engine (#145)
/// this issue defers to doesn't exist yet.
@Entity()
class BusinessRatingEntity {
  @Id()
  int id = 0;

  @Index()
  String businessId;

  String raterId;

  double punctuality;
  double accuracy;
  double communication;
  bool isVerified;

  @Property(type: PropertyType.date)
  DateTime createdAt;

  BusinessRatingEntity({
    this.id = 0,
    required this.businessId,
    required this.raterId,
    required this.punctuality,
    required this.accuracy,
    required this.communication,
    this.isVerified = false,
    required this.createdAt,
  });
}
