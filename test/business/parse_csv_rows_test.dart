import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/parse_csv_rows.dart';

void main() {
  test('splits simple comma-separated rows', () {
    final rows = ParseCsvRows.call('name,sku,price\nChair,C-1,49.99');
    expect(rows, [
      ['name', 'sku', 'price'],
      ['Chair', 'C-1', '49.99'],
    ]);
  });

  test('handles a quoted field containing a comma', () {
    final rows = ParseCsvRows.call('name,category\n"Desk, Standing",Furniture');
    expect(rows[1], ['Desk, Standing', 'Furniture']);
  });

  test('skips blank lines', () {
    final rows = ParseCsvRows.call('a,b\n\nc,d');
    expect(rows.length, 2);
  });
}
