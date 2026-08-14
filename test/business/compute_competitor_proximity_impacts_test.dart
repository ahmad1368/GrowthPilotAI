import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_competitor_proximity_narrative.dart';
import 'package:growth_pilot_ai/business/compute_competitor_proximity_impacts.dart';
import 'package:growth_pilot_ai/core/data/entities/competitor_sighting_entity.dart';

CompetitorSightingEntity _sighting({
  String competitorName = 'Acme Mart',
  String category = 'Grocery',
  required double distanceKm,
  CompetitorScale scale = CompetitorScale.small,
  DateTime? spottedAt,
}) =>
    CompetitorSightingEntity(
      competitorName: competitorName,
      category: category,
      distanceKm: distanceKm,
      spottedAt: spottedAt ?? DateTime(2024, 3, 1),
    )..scale = scale;

void main() {
  group('ComputeCompetitorProximityImpacts', () {
    test('returns empty list when no sightings are logged', () {
      expect(ComputeCompetitorProximityImpacts.call(const []), isEmpty);
    });

    test('scores a closer, larger competitor higher than a distant, small one', () {
      final results = ComputeCompetitorProximityImpacts.call([
        _sighting(
            competitorName: 'Close Large',
            distanceKm: 0.5,
            scale: CompetitorScale.large),
        _sighting(
            competitorName: 'Far Small',
            distanceKm: 4.5,
            scale: CompetitorScale.small),
      ]);

      expect(results.first.competitorName, 'Close Large');
      expect(results.last.competitorName, 'Far Small');
      expect(results.first.impactScore, greaterThan(results.last.impactScore));
    });

    test('guards against division by zero when distance is 0', () {
      final result = ComputeCompetitorProximityImpacts.call(
              [_sighting(distanceKm: 0, scale: CompetitorScale.medium)])
          .single;

      expect(result.impactScore, closeTo(20, 1e-9));
    });

    test('sorts sightings by impact score descending', () {
      final results = ComputeCompetitorProximityImpacts.call([
        _sighting(competitorName: 'Low', distanceKm: 4, scale: CompetitorScale.small),
        _sighting(
            competitorName: 'High', distanceKm: 1, scale: CompetitorScale.large),
      ]);

      expect(results.first.competitorName, 'High');
      expect(results.last.competitorName, 'Low');
    });
  });

  group('BuildCompetitorProximityNarrative', () {
    test('falls back when no sightings are logged', () {
      expect(BuildCompetitorProximityNarrative.call(const []),
          contains('No new competitors logged'));
    });

    test('describes a single logged sighting', () {
      final results = ComputeCompetitorProximityImpacts.call(
          [_sighting(competitorName: 'Acme Mart', distanceKm: 2.0)]);
      final narrative = BuildCompetitorProximityNarrative.call(results);
      expect(narrative, contains('Acme Mart'));
      expect(narrative, contains('2.0km'));
    });

    test('names the biggest threat when multiple exist', () {
      final results = ComputeCompetitorProximityImpacts.call([
        _sighting(competitorName: 'Low', distanceKm: 4, scale: CompetitorScale.small),
        _sighting(
            competitorName: 'High', distanceKm: 1, scale: CompetitorScale.large),
      ]);
      final narrative = BuildCompetitorProximityNarrative.call(results);
      expect(narrative, contains('High'));
    });
  });
}
