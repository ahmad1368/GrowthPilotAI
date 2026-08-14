import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/group_uncategorized_transactions.dart';
import 'package:growth_pilot_ai/core/data/entities/category_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/mapping_rule_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/vendor_entity.dart';
import 'package:growth_pilot_ai/core/models/chart_of_account.dart';

void main() {
  TransactionEntity txn(String vendorName, String categoryName, double amount) {
    final t = TransactionEntity(amount: amount, date: DateTime(2026), description: vendorName);
    t.vendor.target = VendorEntity(name: vendorName);
    t.category.target = CategoryEntity(name: categoryName);
    return t;
  }

  group('GroupUncategorizedTransactions.call', () {
    test('batches transactions from the same merchant into one group', () {
      final groups = GroupUncategorizedTransactions.call(
        transactions: [
          txn('Amazon', 'Shopping', 10),
          txn('Amazon', 'Shopping', 20),
          txn('Uber', 'Travel', 5),
        ],
        rules: const <MappingRuleEntity>[],
        chartOfAccounts: const <ChartOfAccount>[],
      );

      expect(groups.length, 2);
      final amazon = groups.firstWhere((g) => g.merchantName == 'Amazon');
      expect(amazon.transactionCount, 2);
      expect(amazon.totalAmount, 30);
    });

    test('falls back to description when the transaction has no vendor', () {
      final noVendor = TransactionEntity(
          amount: 15, date: DateTime(2026), description: 'Unknown Charge');
      final groups = GroupUncategorizedTransactions.call(
        transactions: [noVendor],
        rules: const <MappingRuleEntity>[],
        chartOfAccounts: const <ChartOfAccount>[],
      );
      expect(groups.single.merchantName, 'Unknown Charge');
    });
  });
}
