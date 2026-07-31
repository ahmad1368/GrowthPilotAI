import 'package:growth_pilot_ai/core/data/entities/competitor_sighting_entity.dart';

/// One logged competitor sighting's proximity threat read (Issue #374):
/// how close and how large the new competitor is, distilled into a single
/// comparable impact score.
class CompetitorProximityImpact {
  final String competitorName;
  final String category;
  final double distanceKm;
  final CompetitorScale scale;
  final DateTime spottedAt;
  final double impactScore;

  const CompetitorProximityImpact({
    required this.competitorName,
    required this.category,
    required this.distanceKm,
    required this.scale,
    required this.spottedAt,
    required this.impactScore,
  });
}
