import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_merged_transaction_view.dart';
import 'package:growth_pilot_ai/core/data/entities/unified_transaction_entity.dart';
import 'package:growth_pilot_ai/core/enum/business_category.dart';
import 'package:growth_pilot_ai/core/enum/transaction_source.dart';

void main() {
  test('prefers the bank posted date and the accounting category/tax', () {
    final bankTx = UnifiedTransactionEntity(
      externalId: 'p1',
      dbSource: TransactionSource.plaid.index,
      amount: 450,
      date: DateTime(2026, 7, 1),
      merchantName: 'HOME DEPOT #451',
    );
    final accountingTx = UnifiedTransactionEntity(
      externalId: 'q1',
      dbSource: TransactionSource.quickbooks.index,
      amount: 450,
      date: DateTime(2026, 7, 3),
      merchantName: 'Home Depot',
      dbCategory: BusinessCategory.officeSupplies.index,
      gst: 22.50,
    );

    final view = BuildMergedTransactionView.call(bankTx, accountingTx);

    expect(view.postedDate, DateTime(2026, 7, 1));
    expect(view.category, BusinessCategory.officeSupplies);
    expect(view.tax.gst, 22.50);
    expect(view.originSources, ['plaid:p1', 'quickbooks:q1']);
  });
}
