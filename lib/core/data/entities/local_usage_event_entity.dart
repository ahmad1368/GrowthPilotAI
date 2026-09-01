import 'package:objectbox/objectbox.dart';
import 'package:growth_pilot_ai/core/enum/usage_event_type.dart';

/// Local, append-only log of first-party in-app usage events (Issue
/// #539) — no Meta/Facebook SDK, cross-app/cross-site tracking,
/// location, contacts, or microphone data is ever collected (see PR
/// notes). This entity never leaves the device.
@Entity()
class LocalUsageEventEntity {
  @Id()
  int id = 0;

  int dbType; // UsageEventType index
  String label;

  @Property(type: PropertyType.date)
  DateTime occurredAt;

  LocalUsageEventEntity({
    this.id = 0,
    required this.dbType,
    required this.label,
    required this.occurredAt,
  });

  UsageEventType get type => UsageEventType.values[dbType];
}
