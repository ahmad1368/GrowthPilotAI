/// Transparent short-term financing fee for a checkout draw (Issue
/// #419, acceptance criterion 2) — mirrors
/// [DefaultConstraintForTier]'s switch-on-tier style. Longer terms
/// carry a higher flat fee rate, disclosed to the merchant before
/// they confirm.
class ComputeFinancingFee {
  static double rateFor(int termDays) {
    return switch (termDays) {
      <= 30 => 0.03,
      _ => 0.05,
    };
  }

  static double call(double principal, int termDays) => principal * rateFor(termDays);
}
