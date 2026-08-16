/// Mean Absolute Percentage Error (Issue #207): `|actual - predicted| /
/// actual * 100`. A zero [actual] has no meaningful percentage error —
/// returns 0 when predicted also matched (both zero), otherwise 100 (a
/// nonzero prediction against zero actual is a total miss).
class ComputeMape {
  static double call(double actual, double predicted) {
    if (actual == 0) return predicted == 0 ? 0 : 100;
    return (actual - predicted).abs() / actual * 100;
  }
}
