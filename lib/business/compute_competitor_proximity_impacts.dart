import 'package:growth_pilot_ai/core/data/entities/competitor_sighting_entity.dart';
import 'package:growth_pilot_ai/core/models/competitor_proximity_impact.dart';

/// Derives each logged competitor sighting's threat level from its scale
/// and distance (Issue #374) — this app has no municipal business-license
/// registry/geospatial feed, so impact is scored from manually-logged
/// sightings instead. Closer and larger competitors score higher.
class ComputeCompetitorProximityImpacts {
  static const _scaleWeight = {
    CompetitorScale.small: 1,
    CompetitorScale.medium: 2,
    CompetitorScale.large: 3,
  };

  static List<CompetitorProximityImpact> call(
      List<CompetitorSightingEntity> sightings) {
    final results = sightings.map((s) {
      final weight = _scaleWeight[s.scale]!;
      final impactScore = weight * (10 / (s.distanceKm + 1));

      return CompetitorProximityImpact(
        competitorName: s.competitorName,
        category: s.category,
        distanceKm: s.distanceKm,
        scale: s.scale,
        spottedAt: s.spottedAt,
        impactScore: impactScore,
      );
    }).toList();

    results.sort((a, b) => b.impactScore.compareTo(a.impactScore));
    return results;
  }
}
