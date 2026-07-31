import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_neighborhood_expansion_narrative.dart';
import 'package:growth_pilot_ai/business/compute_neighborhood_expansion_potential.dart';
import 'package:growth_pilot_ai/core/data/entities/neighborhood_expansion_entity.dart';
import 'package:growth_pilot_ai/core/models/neighborhood_expansion_potential.dart';

NeighborhoodExpansionEntity _evaluation({
  String neighborhoodName = 'Riverside',
  required double estimatedDemandGap,
  required int competitorCount,
  required double estimatedExpansionCost,
  DateTime? evaluatedAt,
}) =>
    NeighborhoodExpansionEntity(
      neighborhoodName: neighborhoodName,
      estimatedDemandGap: estimatedDemandGap,
      competitorCount: competitorCount,
      estimatedExpansionCost: estimatedExpansionCost,
      evaluatedAt: evaluatedAt ?? DateTime(2024, 3, 1),
    );

void main() {
  group('ComputeNeighborhoodExpansionPotential', () {
    test('returns empty list when no evaluations are logged', () {
      expect(ComputeNeighborhoodExpansionPotential.call(const []), isEmpty);
    });

    test('computes net opportunity as demand gap minus cost', () {
      final result = ComputeNeighborhoodExpansionPotential.call([
        _evaluation(
            estimatedDemandGap: 5000, competitorCount: 0, estimatedExpansionCost: 2000)
      ]).single;

      expect(result.netOpportunity, closeTo(3000, 1e-9));
      expect(result.isViable, isTrue);
    });

    test('flags a non-viable evaluation when cost exceeds demand gap', () {
      final result = ComputeNeighborhoodExpansionPotential.call([
        _evaluation(
            estimatedDemandGap: 1000, competitorCount: 0, estimatedExpansionCost: 4000)
      ]).single;

      expect(result.netOpportunity, lessThan(0));
      expect(result.isViable, isFalse);
    });

    test('tiers risk level by competitor count', () {
      final low = ComputeNeighborhoodExpansionPotential.call([
        _evaluation(estimatedDemandGap: 1, competitorCount: 1, estimatedExpansionCost: 0)
      ]).single;
      final medium = ComputeNeighborhoodExpansionPotential.call([
        _evaluation(estimatedDemandGap: 1, competitorCount: 3, estimatedExpansionCost: 0)
      ]).single;
      final high = ComputeNeighborhoodExpansionPotential.call([
        _evaluation(estimatedDemandGap: 1, competitorCount: 4, estimatedExpansionCost: 0)
      ]).single;

      expect(low.riskLevel, ExpansionRiskLevel.low);
      expect(medium.riskLevel, ExpansionRiskLevel.medium);
      expect(high.riskLevel, ExpansionRiskLevel.high);
    });

    test('sorts evaluations by net opportunity descending', () {
      final good = _evaluation(
          neighborhoodName: 'Good',
          estimatedDemandGap: 5000,
          competitorCount: 0,
          estimatedExpansionCost: 1000);
      final bad = _evaluation(
          neighborhoodName: 'Bad',
          estimatedDemandGap: 1000,
          competitorCount: 5,
          estimatedExpansionCost: 4000);

      final results = ComputeNeighborhoodExpansionPotential.call([bad, good]);
      expect(results.first.neighborhoodName, 'Good');
      expect(results.last.neighborhoodName, 'Bad');
    });
  });

  group('BuildNeighborhoodExpansionNarrative', () {
    test('falls back when no evaluations are logged', () {
      expect(BuildNeighborhoodExpansionNarrative.call(const []),
          contains('No neighborhoods evaluated'));
    });

    test('names the top expansion candidate when multiple exist', () {
      final good = _evaluation(
          neighborhoodName: 'Good',
          estimatedDemandGap: 5000,
          competitorCount: 0,
          estimatedExpansionCost: 1000);
      final bad = _evaluation(
          neighborhoodName: 'Bad',
          estimatedDemandGap: 1000,
          competitorCount: 5,
          estimatedExpansionCost: 4000);

      final results = ComputeNeighborhoodExpansionPotential.call([bad, good]);
      final narrative = BuildNeighborhoodExpansionNarrative.call(results);
      expect(narrative, contains('Good'));
    });
  });
}
