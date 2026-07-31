/// Competitor-crowding tier for a logged expansion evaluation
/// (Issue #372).
enum ExpansionRiskLevel { low, medium, high }

/// One logged neighborhood's expansion risk/reward read (Issue #372): net
/// opportunity after cost, and how crowded the target area already is.
class NeighborhoodExpansionPotential {
  final String neighborhoodName;
  final double estimatedDemandGap;
  final int competitorCount;
  final double estimatedExpansionCost;
  final double netOpportunity;
  final ExpansionRiskLevel riskLevel;
  final DateTime evaluatedAt;

  const NeighborhoodExpansionPotential({
    required this.neighborhoodName,
    required this.estimatedDemandGap,
    required this.competitorCount,
    required this.estimatedExpansionCost,
    required this.netOpportunity,
    required this.riskLevel,
    required this.evaluatedAt,
  });

  bool get isViable => netOpportunity > 0;
}
