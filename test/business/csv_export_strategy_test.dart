import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/csv_export_strategy.dart';
import 'package:growth_pilot_ai/core/models/export_options.dart';
import 'package:growth_pilot_ai/core/utils/csv_value_transformer.dart';

void main() {
  final strategy = CsvExportStrategy();

  group('CsvValueTransformer', () {
    test('formats doubles as CAD, dates as ISO day, bools as Yes/No', () {
      expect(CsvValueTransformer.format(1250.0), r'$1,250.00');
      expect(CsvValueTransformer.format(DateTime(2027, 1, 5)), '2027-01-05');
      expect(CsvValueTransformer.format(true), 'Yes');
      expect(CsvValueTransformer.format(null), '');
    });

    test('escapes cells containing commas or quotes', () {
      expect(CsvValueTransformer.escape('a,b'), '"a,b"');
      expect(CsvValueTransformer.escape('say "hi"'), '"say ""hi"""');
      expect(CsvValueTransformer.escape('plain'), 'plain');
    });
  });

  group('CsvExportStrategy.generate', () {
    final rows = [
      {'date': DateTime(2027, 1, 5), 'merchant': 'Staples', 'amount': 42.5},
      {'date': DateTime(2027, 1, 6), 'merchant': 'Acme, Inc', 'amount': 100.0},
    ];

    test('emits only requested fields in order with a header', () {
      final csv = strategy.generate(
          rows, const ExportOptions(fields: ['date', 'amount']));
      final lines = csv.trim().split('\n');
      expect(lines.first, 'date,amount');
      expect(lines[1], r'2027-01-05,$42.50');
    });

    test('quotes values that contain commas', () {
      final csv = strategy.generate(
          rows, const ExportOptions(fields: ['merchant']));
      expect(csv, contains('"Acme, Inc"'));
    });

    test('masks anonymized fields', () {
      final csv = strategy.generate(
        rows,
        const ExportOptions(
            fields: ['merchant', 'amount'], anonymizeFields: {'merchant'}),
      );
      expect(csv, contains('••••'));
      expect(csv, isNot(contains('Staples')));
    });
  });
}
