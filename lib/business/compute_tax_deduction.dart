/// Simulated tax withholding applied to platform fee revenue (Issue
/// #427, acceptance criterion 1) — this app has no real tax-filing
/// integration, so a flat placeholder rate stands in until the
/// dedicated CRA compliance engine (Issue #428) replaces it.
class ComputeTaxDeduction {
  static const simulatedRate = 0.05;

  static double call(double feeRevenue) => feeRevenue * simulatedRate;
}
