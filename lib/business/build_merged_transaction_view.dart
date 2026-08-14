import 'package:growth_pilot_ai/core/data/entities/unified_transaction_entity.dart';
import 'package:growth_pilot_ai/core/enum/transaction_source.dart';
import 'package:growth_pilot_ai/core/models/merged_transaction_view.dart';

/// Applies Issue #69's merge strategy: Plaid ("bank") is the source of
/// truth for the posted date and clearing amount; the accounting provider
/// (QBO/Xero) is the source of truth for category and tax.
class BuildMergedTransactionView {
  static MergedTransactionView call(
    UnifiedTransactionEntity a,
    UnifiedTransactionEntity b,
  ) {
    final bank = a.source == TransactionSource.plaid ? a : b;
    final accounting = identical(bank, a) ? b : a;

    return MergedTransactionView(
      postedDate: bank.date,
      amount: bank.amount,
      merchantName: accounting.merchantName,
      category: accounting.category,
      tax: accounting.tax,
      originSources: [
        '${bank.source.name}:${bank.externalId}',
        '${accounting.source.name}:${accounting.externalId}',
      ],
      matchScore: bank.matchScore ?? accounting.matchScore ?? 0,
    );
  }
}
