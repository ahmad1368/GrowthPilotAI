import 'package:growth_pilot_ai/core/data/entities/neighborhood_expansion_entity.dart';
import 'package:growth_pilot_ai/core/models/neighborhood_expansion_potential.dart';

/// Derives each logged neighborhood evaluation's net opportunity and
/// competitor-crowding risk tier (Issue #372) — this app has no
/// geospatial/census demand-gap feed, so risk/reward is computed from a
/// merchant's own logged market-research estimates instead.
class ComputeNeighborhoodExpansionPotential {
  static List<NeighborhoodExpansionPotential> call(
      List<NeighborhoodExpansionEntity> evaluations) {
    final results = evaluations.map((e) {
      final netOpportunity = e.estimatedDemandGap - e.estimatedExpansionCost;
      final riskLevel = e.competitorCount <= 1
          ? ExpansionRiskLevel.low
          : e.competitorCount <= 3
              ? ExpansionRiskLevel.medium
              : ExpansionRiskLevel.high;

      return NeighborhoodExpansionPotential(
        neighborhoodName: e.neighborhoodName,
        estimatedDemandGap: e.estimatedDemandGap,
        competitorCount: e.competitorCount,
        estimatedExpansionCost: e.estimatedExpansionCost,
        netOpportunity: netOpportunity,
        riskLevel: riskLevel,
        evaluatedAt: e.evaluatedAt,
      );
    }).toList();

    results.sort((a, b) => b.netOpportunity.compareTo(a.netOpportunity));
    return results;
  }
}
