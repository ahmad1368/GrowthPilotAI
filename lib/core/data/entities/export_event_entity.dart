import 'dart:typed_data';
import 'package:objectbox/objectbox.dart';

/// "Audit Logging: every 'Share' action should be logged... as an
/// 'Export Event', providing a history of when and what was shared"
/// (Issue #250) — append-only, same WORM pattern as this repo's #186
/// `SecurityAuditLogEntity`. [fileBytes] (Issue #253) is the locally
/// retained stand-in for the issue's private S3 bucket + presigned
/// URL — no cloud storage exists locally, so the "asset delivery"
/// step is this row itself (see #139's `ImageVariantEntity` for the
/// same "no S3/CDN exists locally" precedent). Nullable so pre-#253
/// rows (no bytes captured) degrade gracefully instead of migrating.
@Entity()
class ExportEventEntity {
  @Id()
  int id = 0;

  String format; // e.g. 'xlsx', 'csv', 'pdf', 'png'
  String filename;
  Uint8List? fileBytes;

  @Property(type: PropertyType.date)
  @Index()
  DateTime occurredAt;

  ExportEventEntity({
    this.id = 0,
    required this.format,
    required this.filename,
    this.fileBytes,
    required this.occurredAt,
  });
}
