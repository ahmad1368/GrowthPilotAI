import 'package:objectbox/objectbox.dart';

/// A downloaded "Intelligence Pack" (Issue #86) — sector benchmark
/// thresholds and Success Signature weights stored locally so the
/// Business Compass (#84) and "Like the Pros" cards (#85) work offline.
/// [benchmarksJson] holds the pack's KPI data; this app has no backend
/// to fetch/sign packs from, so instances are built and verified
/// client-side rather than downloaded via Dio/workmanager.
@Entity()
class IntelligencePackEntity {
  @Id()
  int id = 0;

  @Unique()
  String sectorId;

  int version;

  @Property(type: PropertyType.date)
  DateTime lastSyncedAt;

  String checksumHex;
  String benchmarksJson;

  IntelligencePackEntity({
    this.id = 0,
    required this.sectorId,
    required this.version,
    required this.lastSyncedAt,
    required this.checksumHex,
    required this.benchmarksJson,
  });
}
