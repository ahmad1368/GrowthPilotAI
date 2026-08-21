/// "Dynamically generate the output filename:
/// Traceability_Matrix_[ProjectName]_[Date].xlsx" (Issue #245/#247) —
/// no multi-project concept exists in this repo, so `[ProjectName]` is
/// omitted (see PR notes). [extension] defaults to `xlsx`; #247 also
/// uses `csv`. [baseName] lets #258's batch ZIP reuse the same
/// dated-filename convention under "Project_Bundle" instead.
class BuildTraceabilityExportFilename {
  static String call(DateTime now, {String extension = 'xlsx', String baseName = 'Traceability_Matrix'}) {
    final date = '${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}';
    return '${baseName}_$date.$extension';
  }
}
