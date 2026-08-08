import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_import_row_map.dart';

void main() {
  test('zips header and row into a map', () {
    final map = BuildImportRowMap.call(['name', 'price'], ['Chair', '49.99']);
    expect(map, {'name': 'Chair', 'price': '49.99'});
  });

  test('fills missing trailing cells with empty strings', () {
    final map = BuildImportRowMap.call(['name', 'sku', 'price'], ['Chair']);
    expect(map, {'name': 'Chair', 'sku': '', 'price': ''});
  });
}
