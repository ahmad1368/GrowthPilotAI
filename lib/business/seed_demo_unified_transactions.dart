import 'package:growth_pilot_ai/core/data/entities/unified_transaction_entity.dart';
import 'package:growth_pilot_ai/core/enum/transaction_source.dart';

/// Demo Plaid + accounting records shown the first time the Duplicate
/// Matches screen opens (Issue #69) — stands in for a real Plaid webhook
/// and a QBO/Xero sync since no backend exists in this repo yet. Mirrors
/// the issue's own example: a $450 Home Depot purchase logged twice.
class SeedDemoUnifiedTransactions {
  static List<UnifiedTransactionEntity> call(
      List<UnifiedTransactionEntity> existing) {
    if (existing.isNotEmpty) return [];
    final today = DateTime.now();
    return [
      UnifiedTransactionEntity(
        externalId: 'plaid-hd-451',
        dbSource: TransactionSource.plaid.index,
        amount: 450.00,
        date: today,
        merchantName: 'HOME DEPOT #451',
      ),
      UnifiedTransactionEntity(
        externalId: 'qbo-hd-9001',
        dbSource: TransactionSource.quickbooks.index,
        amount: 450.00,
        date: today.subtract(const Duration(days: 1)),
        merchantName: 'Home Depot',
        rawCategory: 'Repairs & Maintenance',
      ),
      UnifiedTransactionEntity(
        externalId: 'xero-utilities-77',
        dbSource: TransactionSource.xero.index,
        amount: 128.40,
        date: today.subtract(const Duration(days: 2)),
        merchantName: 'BC Hydro',
        rawCategory: 'Utilities',
      ),
    ];
  }
}
