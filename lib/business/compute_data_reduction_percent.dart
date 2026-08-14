/// Percentage byte-size reduction of an optimized variant vs. the
/// original (Issue #139, acceptance criterion "Data Reduction").
class ComputeDataReductionPercent {
  static double call(int originalBytes, int optimizedBytes) {
    if (originalBytes <= 0) return 0;
    final reduction = (1 - optimizedBytes / originalBytes) * 100;
    return reduction < 0 ? 0 : reduction;
  }
}
