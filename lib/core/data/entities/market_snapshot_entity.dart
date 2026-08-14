import 'package:objectbox/objectbox.dart';

/// One daily "State of the Market" aggregate (Issue #102) — a separate
/// ObjectBox box holding only category/region-level averages, never an
/// individual id or raw coordinate (AC: "Privacy Maintenance").
@Entity()
class MarketSnapshotEntity {
  @Id()
  int id = 0;

  @Index()
  String category;

  @Index()
  String region;

  double avgPrice;
  int itemCount;

  @Index()
  @Property(type: PropertyType.date)
  DateTime snapshotDate;

  MarketSnapshotEntity({
    this.id = 0,
    required this.category,
    required this.region,
    required this.avgPrice,
    required this.itemCount,
    required this.snapshotDate,
  });
}
