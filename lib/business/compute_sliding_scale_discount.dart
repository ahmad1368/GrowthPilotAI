/// Sliding-scale volume discount for a seasonal pre-order, by
/// quantity reserved (Issue #417, acceptance criterion 1) — mirrors
/// [DefaultConstraintForTier]'s switch-on-tier style.
class ComputeSlidingScaleDiscount {
  static double call(int quantity) {
    return switch (quantity) {
      >= 50 => 0.20,
      >= 10 => 0.10,
      _ => 0.0,
    };
  }
}
