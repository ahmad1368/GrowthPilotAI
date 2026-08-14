import 'package:growth_pilot_ai/core/models/neighborhood_expansion_potential.dart';

/// One-sentence read naming the best logged expansion opportunity
/// (Issue #372).
class BuildNeighborhoodExpansionNarrative {
  static String call(List<NeighborhoodExpansionPotential> results) {
    if (results.isEmpty) {
      return 'No neighborhoods evaluated yet — add one to start tracking expansion potential.';
    }
    final best = results.first;
    if (results.length == 1) {
      return best.isViable
          ? '${best.neighborhoodName} looks viable with a net opportunity of \$${best.netOpportunity.toStringAsFixed(0)}.'
          : '${best.neighborhoodName} is not yet viable — cost outweighs demand gap.';
    }
    return '${best.neighborhoodName} is your top expansion candidate at \$${best.netOpportunity.toStringAsFixed(0)} net opportunity '
        '(${best.riskLevel.name} competitor risk).';
  }
}
