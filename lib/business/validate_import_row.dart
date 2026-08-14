/// Validates one parsed CSV row before import (Issue #141, "Schema
/// Validation" — required fields present, price a valid positive
/// number).
class ValidateImportRow {
  static List<String> call(Map<String, String> row) {
    final errors = <String>[];
    for (final field in ['name', 'sku', 'category', 'industry']) {
      if ((row[field] ?? '').isEmpty) errors.add('Missing $field.');
    }
    final price = double.tryParse(row['price'] ?? '');
    if (price == null || price <= 0) errors.add('Invalid price format.');
    return errors;
  }
}
