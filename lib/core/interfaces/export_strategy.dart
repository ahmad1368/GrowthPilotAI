import 'package:growth_pilot_ai/core/models/export_options.dart';

/// Strategy for serializing tabular rows into an export format. Additional
/// providers (Excel, PDF) can implement this without changing callers.
abstract class ExportStrategy {
  /// Lowercase format key, e.g. `csv`.
  String get format;

  /// Serializes [rows] using the columns/anonymization in [options].
  String generate(List<Map<String, dynamic>> rows, ExportOptions options);
}
