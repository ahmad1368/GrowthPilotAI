import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/map_import_row.dart';

void main() {
  test('maps fields using the explicit column indices', () {
    final row = MapImportRow.call({'name': 1, 'sku': 0}, ['C-1', 'Chair']);
    expect(row, {'name': 'Chair', 'sku': 'C-1'});
  });

  test('leaves unmapped or out-of-range fields empty', () {
    final row = MapImportRow.call({'name': null, 'sku': 5}, ['Chair']);
    expect(row, {'name': '', 'sku': ''});
  });
}
