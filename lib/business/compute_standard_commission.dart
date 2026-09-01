/// The platform's baseline marketplace commission (Issue #420,
/// acceptance criterion 2) — this app had no commission concept
/// before this issue, since every prior marketplace feature
/// (#411-#419) credited 100% of proceeds to the seller; this
/// introduces the flat rate the zero-commission incentive waives.
class ComputeStandardCommission {
  static const rate = 0.05;

  static double call(double grossAmount) => grossAmount * rate;
}
