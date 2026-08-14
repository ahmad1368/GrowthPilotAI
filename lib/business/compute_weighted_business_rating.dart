/// "Bayesian Average Implementation" (Issue #125 AC: "Fairness" — a
/// business with 100 reviews at 4.5 outranks one with a single 5.0
/// review): `(v/(v+m))*R + (m/(v+m))*C`.
class ComputeWeightedBusinessRating {
  static double call({
    required int reviewCount,
    required double averageRating,
    required double globalAverage,
    int minReviews = 5,
  }) {
    if (reviewCount == 0) return globalAverage;
    final v = reviewCount.toDouble();
    final m = minReviews.toDouble();
    return (v / (v + m)) * averageRating + (m / (v + m)) * globalAverage;
  }
}
