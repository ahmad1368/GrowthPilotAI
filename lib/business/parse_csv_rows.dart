/// A minimal, dependency-free CSV parser (Issue #141, "Multi-Format
/// Parsing") — handles quoted fields containing commas/quotes, since
/// this app has no server to run `exceljs`/`xlsx` on. `.xlsx` (a
/// binary format) is out of scope without a native/JS-only parsing
/// dependency; only `.csv` text is supported.
class ParseCsvRows {
  static List<List<String>> call(String csvText) {
    final rows = <List<String>>[];
    for (final line in csvText.split(RegExp(r'\r\n|\n'))) {
      if (line.trim().isEmpty) continue;
      rows.add(_parseLine(line));
    }
    return rows;
  }

  static List<String> _parseLine(String line) {
    final cells = <String>[];
    final buffer = StringBuffer();
    var inQuotes = false;
    for (var i = 0; i < line.length; i++) {
      final char = line[i];
      if (char == '"') {
        inQuotes = !inQuotes;
      } else if (char == ',' && !inQuotes) {
        cells.add(buffer.toString().trim());
        buffer.clear();
      } else {
        buffer.write(char);
      }
    }
    cells.add(buffer.toString().trim());
    return cells;
  }
}
