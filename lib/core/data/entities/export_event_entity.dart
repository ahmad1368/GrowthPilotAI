import 'package:objectbox/objectbox.dart';

/// "Audit Logging: every 'Share' action should be logged... as an
/// 'Export Event', providing a history of when and what was shared"
/// (Issue #250) — append-only, same WORM pattern as this repo's #186
/// `SecurityAuditLogEntity`.
@Entity()
class ExportEventEntity {
  @Id()
  int id = 0;

  String format; // e.g. 'xlsx', 'csv', 'pdf', 'png'
  String filename;

  @Property(type: PropertyType.date)
  @Index()
  DateTime occurredAt;

  ExportEventEntity({this.id = 0, required this.format, required this.filename, required this.occurredAt});
}
