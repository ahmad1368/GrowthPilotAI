import 'package:growth_pilot_ai/core/models/cohort_clv_comparison.dart';
import 'package:growth_pilot_ai/core/utils/currency_format.dart';

/// One-sentence read on whether new buyers carry more or less projected
/// value than established ones (Issue #394).
class BuildClvNarrative {
  static String call(CohortClvComparison comparison) {
    if (comparison.newCohortCount == 0 || comparison.establishedCohortCount == 0) {
      return 'Not enough purchase history yet to compare cohorts.';
    }
    final newClv = CurrencyFormat.cad(comparison.newCohortAverageClv);
    final establishedClv = CurrencyFormat.cad(comparison.establishedCohortAverageClv);
    if (comparison.newCohortAverageClv >= comparison.establishedCohortAverageClv) {
      return 'New buyers project $newClv in lifetime value vs $establishedClv for '
          'established ones — recent acquisition is paying off.';
    }
    return 'New buyers project $newClv in lifetime value vs $establishedClv for '
        'established ones — acquisition spend may not be sustainable long-term.';
  }
}
