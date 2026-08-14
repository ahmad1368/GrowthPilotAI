/// Estimated remaining seconds for a batch operation, based on
/// measured throughput so far (Issue #217, "ETA Calculation") — a
/// genuine measurement, not a fabricated countdown.
class ComputeEtaSeconds {
  static double call({required double elapsedSeconds, required int processed, required int total}) {
    if (processed <= 0 || elapsedSeconds <= 0 || total <= processed) return 0;
    final rate = processed / elapsedSeconds;
    return (total - processed) / rate;
  }
}
