/// Tiered wholesale discount unlocked by how far the collective order
/// exceeds its minimum quantity threshold (Issue #414, acceptance
/// criteria 3 and 5) — mirrors [DefaultConstraintForTier]'s
/// switch-on-tier style. Returns 0 if the threshold isn't met.
class ComputeGroupDiscountRate {
  static double call(int totalQuantity, int minQuantityThreshold) {
    if (minQuantityThreshold <= 0 || totalQuantity < minQuantityThreshold) return 0;
    final multiple = totalQuantity / minQuantityThreshold;
    return switch (multiple) {
      >= 2.0 => 0.20,
      >= 1.5 => 0.15,
      _ => 0.10,
    };
  }
}
