import 'package:growth_pilot_ai/core/interfaces/export_strategy.dart';
import 'package:growth_pilot_ai/core/models/export_options.dart';
import 'package:growth_pilot_ai/core/utils/csv_value_transformer.dart';

/// Pure, in-memory CSV exporter. Emits only the requested [ExportOptions.fields]
/// (in order), transforms values to human-readable strings, and masks any
/// anonymized columns. Web-safe — returns a string; saving/sharing is the UI's.
class CsvExportStrategy implements ExportStrategy {
  static const String _mask = '••••';

  @override
  String get format => 'csv';

  @override
  String generate(List<Map<String, dynamic>> rows, ExportOptions options) {
    final buffer = StringBuffer();
    buffer.writeln(options.fields.map(CsvValueTransformer.escape).join(','));
    for (final row in rows) {
      final cells = options.fields.map((field) {
        if (options.anonymizeFields.contains(field)) return _mask;
        return CsvValueTransformer.escape(
            CsvValueTransformer.format(row[field]));
      });
      buffer.writeln(cells.join(','));
    }
    return buffer.toString();
  }
}
