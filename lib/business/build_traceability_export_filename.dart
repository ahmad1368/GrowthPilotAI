/// "Dynamically generate the output filename:
/// Traceability_Matrix_[ProjectName]_[Date].xlsx" (Issue #245/#247) —
/// no multi-project concept exists in this repo, so `[ProjectName]` is
/// omitted (see PR notes). [extension] defaults to `xlsx`; #247 also
/// uses `csv`.
class BuildTraceabilityExportFilename {
  static String call(DateTime now, {String extension = 'xlsx'}) {
    final date = '${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}';
    return 'Traceability_Matrix_$date.$extension';
  }
}
