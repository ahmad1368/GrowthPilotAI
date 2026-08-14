import 'package:growth_pilot_ai/core/enum/customer_cohort.dart';
import 'package:growth_pilot_ai/core/models/cohort_clv_comparison.dart';
import 'package:growth_pilot_ai/core/models/customer_lifetime_value.dart';

/// Averages CLV within each acquisition cohort (Issue #394).
class ComputeCohortClvComparison {
  static CohortClvComparison call(List<CustomerLifetimeValue> clvs) {
    final newCohort =
        clvs.where((c) => c.cohort == CustomerCohort.newCustomer).toList();
    final established =
        clvs.where((c) => c.cohort == CustomerCohort.established).toList();

    return CohortClvComparison(
      newCohortAverageClv: _average(newCohort),
      establishedCohortAverageClv: _average(established),
      newCohortCount: newCohort.length,
      establishedCohortCount: established.length,
    );
  }

  static double _average(List<CustomerLifetimeValue> clvs) {
    if (clvs.isEmpty) return 0;
    return clvs.fold<double>(0, (sum, c) => sum + c.lifetimeValue) / clvs.length;
  }
}
