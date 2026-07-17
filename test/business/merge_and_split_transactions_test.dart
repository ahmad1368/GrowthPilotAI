import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/merge_unified_transactions.dart';
import 'package:growth_pilot_ai/business/split_merged_transaction.dart';
import 'package:growth_pilot_ai/core/data/entities/unified_transaction_entity.dart';
import 'package:growth_pilot_ai/core/enum/transaction_source.dart';

void main() {
  UnifiedTransactionEntity tx(String id, TransactionSource source) =>
      UnifiedTransactionEntity(
        externalId: id,
        dbSource: source.index,
        amount: 450,
        date: DateTime(2026, 7, 1),
        merchantName: 'Home Depot',
      );

  test('MergeUnifiedTransactions groups both records under a shared id without deleting data', () {
    final bankTx = tx('p1', TransactionSource.plaid);
    final accountingTx = tx('q1', TransactionSource.quickbooks);

    final groupId = MergeUnifiedTransactions.call(bankTx, accountingTx);

    expect(bankTx.mergeGroupId, groupId);
    expect(accountingTx.mergeGroupId, groupId);
    expect(bankTx.externalId, 'p1');
    expect(accountingTx.externalId, 'q1');
  });

  test('SplitMergedTransaction fully reverses a merge', () {
    final bankTx = tx('p1', TransactionSource.plaid);
    final accountingTx = tx('q1', TransactionSource.quickbooks);
    bankTx.matchScore = 0.95;
    accountingTx.matchScore = 0.95;
    MergeUnifiedTransactions.call(bankTx, accountingTx);

    SplitMergedTransaction.call(bankTx, accountingTx);

    expect(bankTx.isMerged, isFalse);
    expect(accountingTx.isMerged, isFalse);
    expect(bankTx.matchScore, isNull);
    expect(accountingTx.matchScore, isNull);
  });
}
