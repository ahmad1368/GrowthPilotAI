import 'package:objectbox/objectbox.dart';

/// One immutable record of an admin-driven change to a merchant (Issue
/// #343) — this app has no backend audit service, so admin actions
/// across the admin panels write here directly. [AuditLogRepository]
/// exposes no update/delete, only `record`/`getAll`, so once written a
/// row can never be altered (acceptance criterion 3).
@Entity()
class AuditLogEntity {
  @Id()
  int id = 0;

  @Index()
  String adminId;

  String changeType;

  @Index()
  String targetMerchant;

  String previousValue;

  String newValue;

  @Index()
  @Property(type: PropertyType.date)
  DateTime timestamp;

  AuditLogEntity({
    this.id = 0,
    required this.adminId,
    required this.changeType,
    required this.targetMerchant,
    this.previousValue = '',
    required this.newValue,
    required this.timestamp,
  });
}
