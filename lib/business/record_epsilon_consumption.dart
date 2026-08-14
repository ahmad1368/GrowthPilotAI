/// Accumulates epsilon spend (Issue #81: "Log the total Epsilon
/// Consumption per user/session").
class RecordEpsilonConsumption {
  static double call(double previousTotal, double epsilonSpent) =>
      previousTotal + epsilonSpent;
}
