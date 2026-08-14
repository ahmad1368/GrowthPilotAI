import 'package:objectbox/objectbox.dart';

/// One item's cached [DistilledContext] (Issue #105) — the local
/// "Intelligence Node" storage the Edge Downloader writes to so the
/// Radar Chart (#99) and Efficiency Gap (#100) render offline. Only
/// derived scores are stored, never a raw price or address (AC:
/// "Privacy Integrity").
@Entity()
class IntelligenceCacheEntryEntity {
  @Id()
  int id = 0;

  @Unique()
  @Index()
  String itemId;

  String sectorId;
  int marketTemperatureIndex;
  double? pricePosition;
  double scarcityIndex;
  bool isHiddenGem;

  @Property(type: PropertyType.date)
  DateTime syncedAt;

  IntelligenceCacheEntryEntity({
    this.id = 0,
    required this.itemId,
    required this.sectorId,
    required this.marketTemperatureIndex,
    required this.pricePosition,
    required this.scarcityIndex,
    required this.isHiddenGem,
    required this.syncedAt,
  });
}
