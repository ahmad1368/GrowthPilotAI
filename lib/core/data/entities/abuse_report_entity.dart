import 'package:objectbox/objectbox.dart';
import 'package:growth_pilot_ai/core/enum/moderation_reason.dart';

/// One "Report User/Business" submission (Issue #134) — [evidenceSnapshot]
/// is a denormalized copy of the last 10 messages ("Moderation Vault"),
/// since there's no separate encrypted evidence store locally.
@Entity()
class AbuseReportEntity {
  @Id()
  int id = 0;

  String reporterId;

  @Index()
  String targetId;

  int dbReason; // ModerationReason index
  String evidenceSnapshot;
  bool isReviewed;

  @Property(type: PropertyType.date)
  DateTime createdAt;

  AbuseReportEntity({
    this.id = 0,
    required this.reporterId,
    required this.targetId,
    required this.dbReason,
    required this.evidenceSnapshot,
    this.isReviewed = false,
    required this.createdAt,
  });

  ModerationReason get reason => ModerationReason.values[dbReason];
}
