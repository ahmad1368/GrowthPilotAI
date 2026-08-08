import 'package:growth_pilot_ai/features/catalog/widgets/run_bulk_import_preview.dart';

/// Applies a single column-mapping change to the current preview
/// state (Issue #213) — split out of [BulkImportBody].
BulkImportPreviewState? applyColumnMapChange(BulkImportPreviewState? state, String field, int? index) {
  if (state == null) return null;
  return (header: state.header, columnMap: {...state.columnMap, field: index}, results: state.results);
}
