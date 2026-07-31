import 'package:flutter/foundation.dart';

/// Average CLV for the new-customer cohort vs the established cohort
/// (Issue #394) — lets a merchant see whether recently acquired buyers
/// carry more or less long-term value than historical ones.
@immutable
class CohortClvComparison {
  final double newCohortAverageClv;
  final double establishedCohortAverageClv;
  final int newCohortCount;
  final int establishedCohortCount;

  const CohortClvComparison({
    required this.newCohortAverageClv,
    required this.establishedCohortAverageClv,
    required this.newCohortCount,
    required this.establishedCohortCount,
  });
}
