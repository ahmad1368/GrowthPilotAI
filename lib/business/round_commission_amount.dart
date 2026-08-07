/// Rounds a computed commission amount to whole cents (Issue #425,
/// acceptance criterion 4) — applied once, after all rate math, so
/// high-frequency settlement never accumulates fractional-cent drift.
class RoundCommissionAmount {
  static double call(double amount) => (amount * 100).round() / 100;
}
