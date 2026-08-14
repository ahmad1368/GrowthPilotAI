import 'package:objectbox/objectbox.dart';

/// One login or dashboard-visit event for a marketplace merchant
/// (Issue #424, acceptance criterion 1) — this app has no auth/session
/// system, so these are admin-logged telemetry points rather than
/// captured automatically, mirroring [AuditLogEntity]'s manual-entry
/// pattern.
@Entity()
class MerchantActivityEventEntity {
  @Id()
  int id = 0;

  @Index()
  String merchantName;

  int dbEventType;

  @Index()
  @Property(type: PropertyType.date)
  DateTime occurredAt;

  MerchantActivityEventEntity({
    this.id = 0,
    required this.merchantName,
    this.dbEventType = 0,
    required this.occurredAt,
  });
}
