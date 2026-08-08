import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/validate_import_row.dart';

void main() {
  test('passes a fully populated valid row', () {
    final errors = ValidateImportRow.call(
        {'name': 'Chair', 'sku': 'C-1', 'category': 'Seating', 'industry': 'Furniture', 'price': '49.99'});
    expect(errors, isEmpty);
  });

  test('flags missing required fields', () {
    final errors = ValidateImportRow.call({'price': '10'});
    expect(errors, containsAll(['Missing name.', 'Missing sku.', 'Missing category.', 'Missing industry.']));
  });

  test('flags a non-numeric price', () {
    final errors = ValidateImportRow.call(
        {'name': 'Chair', 'sku': 'C-1', 'category': 'x', 'industry': 'y', 'price': 'free'});
    expect(errors, contains('Invalid price format.'));
  });

  test('flags a zero or negative price', () {
    final errors = ValidateImportRow.call(
        {'name': 'Chair', 'sku': 'C-1', 'category': 'x', 'industry': 'y', 'price': '0'});
    expect(errors, contains('Invalid price format.'));
  });
}
