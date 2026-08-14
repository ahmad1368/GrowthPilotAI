/// "How rare is this item in this grid?" (Issue #103) — mirrors the
/// issue's own `1 / peerGroup.length`. A peer group of 0 (the item is
/// the only one) is treated as maximally scarce rather than dividing by
/// zero.
class ComputeScarcityIndex {
  static double call(int peerGroupSize) => peerGroupSize <= 0 ? 1.0 : 1.0 / peerGroupSize;
}
