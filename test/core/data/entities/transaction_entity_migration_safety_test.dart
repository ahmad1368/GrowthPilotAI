import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';

void main() {
  group('TransactionEntity migration safety (Issue #18 AC)', () {
    test('constructs with only the original required fields', () {
      // Every field added to TransactionEntity after its initial version
      // (dbPaymentMethod, memo, lastModified, isDeleted, remoteId, id,
      // dbType, dbSyncStatus) must have a safe default. Otherwise a record
      // written before that field existed - or a caller mirroring the
      // entity's original minimal shape - could no longer construct one,
      // matching MIGRATION.md's "additive/nullable-or-defaulted" rule.
      final transaction = TransactionEntity(
        amount: 89.50,
        date: DateTime(2026, 1, 1),
        description: 'Original-shape construction',
      );

      expect(transaction.id, 0);
      expect(transaction.remoteId, isNull);
      expect(transaction.type, TransactionType.expense);
      expect(transaction.syncStatus, SyncStatus.pending);
      expect(transaction.paymentMethod, PaymentMethod.unspecified);
      expect(transaction.memo, isNull);
      expect(transaction.isDeleted, isFalse);
      expect(transaction.lastModified, DateTime.fromMillisecondsSinceEpoch(0, isUtc: true));
      expect(transaction.category.target, isNull);
      expect(transaction.vendor.target, isNull);
    });
  });
}
