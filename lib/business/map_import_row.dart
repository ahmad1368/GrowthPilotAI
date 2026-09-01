/// Builds a field->value row map from an explicit column mapping
/// (Issue #213, "Mapping Wizard") instead of assuming a vendor's
/// header text matches our field names exactly.
class MapImportRow {
  static Map<String, String> call(Map<String, int?> columnMap, List<String> row) {
    final map = <String, String>{};
    columnMap.forEach((field, index) {
      map[field] = (index != null && index < row.length) ? row[index].trim() : '';
    });
    return map;
  }
}
