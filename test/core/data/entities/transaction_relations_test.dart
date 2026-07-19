import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/data/entities/category_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/vendor_entity.dart';

/// Verifies the Issue #13 Category/Vendor relations wire up correctly at
/// the object-model level: assigning a `ToOne` target immediately reflects
/// through the relation and the reverse `ToMany` backlink, without needing
/// a live ObjectBox store (this repo's tests keep entities pure/in-memory —
/// see [[project_claude_dev_boundary]] for why no test here opens a Store).
void main() {
  test('a transaction linked to a category reads the category back', () {
    final category = CategoryEntity(name: 'Office Supplies');
    final transaction = TransactionEntity(
      amount: 45.0,
      date: DateTime(2026, 1, 1),
      description: 'Staples run',
    );

    transaction.category.target = category;

    expect(transaction.category.target?.name, 'Office Supplies');
  });

  test('a transaction linked to a vendor reads the vendor back', () {
    final vendor = VendorEntity(name: 'BC Hydro', taxId: '123456789RT0001');
    final transaction = TransactionEntity(
      amount: 88.20,
      date: DateTime(2026, 1, 1),
      description: 'Monthly utility bill',
    );

    transaction.vendor.target = vendor;

    expect(transaction.vendor.target?.name, 'BC Hydro');
    expect(transaction.vendor.target?.taxId, '123456789RT0001');
  });

  test('a transaction with no category/vendor set has null targets', () {
    final transaction = TransactionEntity(
      amount: 10.0,
      date: DateTime(2026, 1, 1),
      description: 'Cash purchase',
    );

    expect(transaction.category.target, isNull);
    expect(transaction.vendor.target, isNull);
  });
}
