import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/enum/business_category.dart';
import 'package:growth_pilot_ai/core/utils/transaction_category_mapper.dart';

void main() {
  group('TransactionCategoryMapper.fromPlaid', () {
    test('maps known Plaid categories into the B2B taxonomy', () {
      expect(TransactionCategoryMapper.fromPlaid('Rent'),
          BusinessCategory.rent);
      expect(TransactionCategoryMapper.fromPlaid('Food and Drink'),
          BusinessCategory.meals);
      expect(TransactionCategoryMapper.fromPlaid('  UTILITIES '),
          BusinessCategory.utilities);
    });

    test('falls back to uncategorized for unknown categories', () {
      expect(TransactionCategoryMapper.fromPlaid('Crypto'),
          BusinessCategory.uncategorized);
    });

    test('handles a null category', () {
      expect(TransactionCategoryMapper.fromPlaid(null),
          BusinessCategory.uncategorized);
    });
  });
}
