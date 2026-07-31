import 'package:objectbox/objectbox.dart';

/// Estimated operational scale of a newly spotted competitor (Issue #374).
enum CompetitorScale { small, medium, large }

/// A manually-logged new-competitor sighting (Issue #374) — this app has
/// no municipal business-license registry/geospatial feed, so a merchant
/// records what they observed nearby, the same lightweight logging
/// pattern [WasteLogEntity] uses.
@Entity()
class CompetitorSightingEntity {
  @Id()
  int id = 0;

  String competitorName;

  String category;

  double distanceKm;

  int dbScale;

  @Index()
  @Property(type: PropertyType.date)
  DateTime spottedAt;

  CompetitorSightingEntity({
    this.id = 0,
    required this.competitorName,
    required this.category,
    required this.distanceKm,
    required this.spottedAt,
    this.dbScale = 0,
  });

  CompetitorScale get scale => CompetitorScale.values[dbScale];
  set scale(CompetitorScale value) => dbScale = value.index;
}
