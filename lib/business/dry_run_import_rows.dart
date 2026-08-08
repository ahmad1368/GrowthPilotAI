import 'package:growth_pilot_ai/business/detect_duplicate_sku.dart';
import 'package:growth_pilot_ai/business/map_import_row.dart';
import 'package:growth_pilot_ai/business/validate_import_row.dart';

typedef DryRunRowResult = ({int row, bool valid, String error});

/// Validates every data row against the current mapping WITHOUT
/// saving anything (Issue #213, "Dry-Run Preview") — also catches
/// duplicate SKUs within the same file, not just against existing
/// data.
class DryRunImportRows {
  static List<DryRunRowResult> call(
    List<List<String>> dataRows,
    Map<String, int?> columnMap,
    Set<String> existingSkus,
  ) {
    final seenSkus = <String>{...existingSkus};
    final results = <DryRunRowResult>[];
    for (var i = 0; i < dataRows.length; i++) {
      final map = MapImportRow.call(columnMap, dataRows[i]);
      final errors = ValidateImportRow.call(map);
      final sku = map['sku'] ?? '';
      if (errors.isEmpty && DetectDuplicateSku.call(sku, seenSkus)) {
        errors.add('Duplicate SKU.');
      }
      if (errors.isEmpty) seenSkus.add(sku);
      results.add((row: i + 2, valid: errors.isEmpty, error: errors.join('; ')));
    }
    return results;
  }
}
