import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/guess_column_mapping.dart';

void main() {
  test('matches header cells that exactly equal the field name', () {
    final map = GuessColumnMapping.call(['name', 'sku', 'category', 'industry', 'price']);
    expect(map, {'name': 0, 'sku': 1, 'category': 2, 'industry': 3, 'price': 4});
  });

  test('is case-insensitive', () {
    final map = GuessColumnMapping.call(['NAME', 'SKU']);
    expect(map['name'], 0);
    expect(map['sku'], 1);
  });

  test('leaves unmatched fields null', () {
    final map = GuessColumnMapping.call(['Item Name']);
    expect(map['name'], isNull);
  });
}
