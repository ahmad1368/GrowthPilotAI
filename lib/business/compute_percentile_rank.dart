/// "Percentile Math Function" (Issue #96 scope item 2): the mid-rank
/// formula `(L + 0.5*S) / N * 100`, where L is the count of peers below
/// [targetValue], S the count tied with it, and N the peer group size —
/// domain-agnostic over whatever numeric value (price, distance, match
/// score, ...) the caller supplies. Returns null below
/// [minimumSampleSize] (the "Privacy Buffer" AC, reusing #90's k-anonymity
/// threshold) rather than a percentile computed from too few peers.
class ComputePercentileRank {
  static int? call(
    double targetValue,
    List<double> peerGroup, {
    int minimumSampleSize = 5,
  }) {
    if (peerGroup.length < minimumSampleSize) return null;

    final lowerCount = peerGroup.where((v) => v < targetValue).length;
    final equalCount = peerGroup.where((v) => v == targetValue).length;
    final rank = (lowerCount + 0.5 * equalCount) / peerGroup.length * 100;
    return rank.round();
  }
}
