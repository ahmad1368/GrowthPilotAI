import 'package:objectbox/objectbox.dart';

/// A manually-logged expansion evaluation for a neighboring district
/// (Issue #372) — this app has no geospatial/census demand-gap feed, so a
/// merchant records their own market-research estimate here, the same
/// lightweight logging pattern [CompetitorSightingEntity] uses.
@Entity()
class NeighborhoodExpansionEntity {
  @Id()
  int id = 0;

  String neighborhoodName;

  double estimatedDemandGap;

  int competitorCount;

  double estimatedExpansionCost;

  @Index()
  @Property(type: PropertyType.date)
  DateTime evaluatedAt;

  NeighborhoodExpansionEntity({
    this.id = 0,
    required this.neighborhoodName,
    required this.estimatedDemandGap,
    required this.competitorCount,
    required this.estimatedExpansionCost,
    required this.evaluatedAt,
  });
}
