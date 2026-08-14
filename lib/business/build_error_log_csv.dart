/// Renders the failed-row error list as a downloadable-shaped CSV
/// (Issue #213, "Feedback Loop" — copied via Clipboard since there's
/// no OS file-save dialog wired up).
class BuildErrorLogCsv {
  static String call(List<({int row, String error})> errors) {
    final buffer = StringBuffer('row,error\n');
    for (final e in errors) {
      buffer.writeln('${e.row},"${e.error.replaceAll('"', '""')}"');
    }
    return buffer.toString();
  }
}
