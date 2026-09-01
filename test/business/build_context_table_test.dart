import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_context_table.dart';
import 'package:growth_pilot_ai/core/models/context_record.dart';

void main() {
  group('BuildContextTable', () {
    test('renders a Markdown table row per record', () {
      final table = BuildContextTable.call([
        ContextRecord(date: DateTime(2026, 3, 5), merchant: 'ABC Logistics', amount: 500, category: 'fuel'),
      ]);

      expect(table, contains('| Date | Merchant | Amount | Category |'));
      expect(table, contains('| 2026-03-05 | ABC Logistics | \$500.00 | fuel |'));
    });

    test('shows a placeholder instead of an empty table (AC: No Data Found)', () {
      expect(BuildContextTable.call(const []), 'No relevant data found.');
    });
  });
}
