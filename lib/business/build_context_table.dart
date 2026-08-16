import 'package:growth_pilot_ai/core/models/context_record.dart';

/// Markdown table of financial context rows (Issue #199's worked
/// example format) — a "No relevant data found" placeholder when
/// [records] is empty, so the SLM never receives an empty/broken table
/// (AC: "handles No Data Found scenarios without crashing").
class BuildContextTable {
  static String call(List<ContextRecord> records) {
    if (records.isEmpty) return 'No relevant data found.';
    final buffer = StringBuffer('| Date | Merchant | Amount | Category |\n|---|---|---|---|\n');
    for (final r in records) {
      buffer.writeln('| ${r.date.toIso8601String().split('T').first} | ${r.merchant} | '
          '\$${r.amount.toStringAsFixed(2)} | ${r.category} |');
    }
    return buffer.toString().trim();
  }
}
