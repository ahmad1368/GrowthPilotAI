/// The Fair Price Index: how a candidate listing price compares to
/// the regional baseline (Issue #416, acceptance criterion 2) — above
/// 1.0 means the listing is cheaper than the regional market
/// (a deal), below 1.0 means it's pricier (overpriced).
class ComputeFairPriceIndex {
  static double call(double candidatePrice, double baselinePrice) {
    if (baselinePrice <= 0 || candidatePrice <= 0) return 1.0;
    return baselinePrice / candidatePrice;
  }
}
