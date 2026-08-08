import 'package:objectbox/objectbox.dart';
import 'package:growth_pilot_ai/core/enum/moderation_reason.dart';

/// One reputation-score strike against a profile (Issue #124) — expires
/// after its TTL (90 days) unless [isCritical], which never expires and
/// counts toward suspension immediately.
@Entity()
class StrikeEntity {
  @Id()
  int id = 0;

  @Index()
  String targetId;

  int dbReason; // ModerationReason index
  bool isCritical;

  @Property(type: PropertyType.date)
  DateTime createdAt;

  @Property(type: PropertyType.date)
  DateTime? expiresAt;

  StrikeEntity({
    this.id = 0,
    required this.targetId,
    required this.dbReason,
    this.isCritical = false,
    required this.createdAt,
    this.expiresAt,
  });

  ModerationReason get reason => ModerationReason.values[dbReason];
}
