/// "req_code VARCHAR(10), e.g. 'BR-01'" / "tc_code, e.g. 'TC-102'"
/// (Issue #242) — the next sequential code for [prefix], zero-padded
/// to 2 digits, based on how many already exist.
class GenerateTraceabilityCode {
  static String call(String prefix, int existingCount) {
    final next = existingCount + 1;
    return '$prefix-${next.toString().padLeft(2, '0')}';
  }
}
