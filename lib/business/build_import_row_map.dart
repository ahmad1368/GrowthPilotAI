/// Zips a CSV header row with a data row into a lowercase-keyed map
/// (Issue #141, "Data Cleaning" — trims whitespace on every cell).
/// Extra/missing cells are tolerated (mapped as empty).
class BuildImportRowMap {
  static Map<String, String> call(List<String> header, List<String> row) {
    final map = <String, String>{};
    for (var i = 0; i < header.length; i++) {
      map[header[i]] = i < row.length ? row[i].trim() : '';
    }
    return map;
  }
}
