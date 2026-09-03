import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/data/entities/category_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/vendor_entity.dart';

void main() {
  group('TransactionEntity relations (Issue #13 AC)', () {
    test('linking a category to a transaction retrieves its name back', () {
      final category = CategoryEntity(name: 'Utilities');
      final transaction = TransactionEntity(
        amount: 142.35,
        date: DateTime(2026, 1, 1),
        description: 'BC Hydro bill',
      );

      transaction.category.target = category;

      expect(transaction.category.target, isNotNull);
      expect(transaction.category.target!.name, 'Utilities');
    });

    test('linking a vendor to a transaction retrieves its name and taxId back', () {
      final vendor = VendorEntity(name: 'BC Hydro', taxId: '123456789RT0001');
      final transaction = TransactionEntity(
        amount: 142.35,
        date: DateTime(2026, 1, 1),
        description: 'Monthly electricity',
      );

      transaction.vendor.target = vendor;

      expect(transaction.vendor.target, isNotNull);
      expect(transaction.vendor.target!.name, 'BC Hydro');
      expect(transaction.vendor.target!.taxId, '123456789RT0001');
    });

    test('a transaction with no linked category/vendor has null targets', () {
      final transaction = TransactionEntity(
        amount: 25.00,
        date: DateTime(2026, 1, 1),
        description: 'Unlinked transaction',
      );

      expect(transaction.category.target, isNull);
      expect(transaction.vendor.target, isNull);
    });
  });
}
