import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/dry_run_import_rows.dart';

void main() {
  const map = {'name': 0, 'sku': 1, 'category': 2, 'industry': 3, 'price': 4};

  test('marks a fully valid row as valid with the correct file row number', () {
    final results = DryRunImportRows.call([
      ['Chair', 'C-1', 'Seating', 'Furniture', '49.99'],
    ], map, {});
    expect(results.single.valid, isTrue);
    expect(results.single.row, 2);
  });

  test('flags a row invalid without saving anything', () {
    final results = DryRunImportRows.call([
      ['', 'C-1', 'Seating', 'Furniture', '49.99'],
    ], map, {});
    expect(results.single.valid, isFalse);
  });

  test('flags a SKU duplicated within the same file, not just existing data', () {
    final rows = [
      ['Chair', 'C-1', 'Seating', 'Furniture', '49.99'],
      ['Stool', 'C-1', 'Seating', 'Furniture', '19.99'],
    ];
    final results = DryRunImportRows.call(rows, map, {});
    expect(results[0].valid, isTrue);
    expect(results[1].valid, isFalse);
  });

  test('flags a SKU that already exists in the database', () {
    final results = DryRunImportRows.call([
      ['Chair', 'C-1', 'Seating', 'Furniture', '49.99'],
    ], map, {'C-1'});
    expect(results.single.valid, isFalse);
  });
}
