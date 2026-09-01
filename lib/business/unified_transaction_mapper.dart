import 'package:growth_pilot_ai/core/enum/transaction_source.dart';
import 'package:growth_pilot_ai/core/models/plaid_transaction.dart';
import 'package:growth_pilot_ai/core/models/unified_transaction.dart';
import 'package:growth_pilot_ai/core/utils/transaction_category_mapper.dart';

/// Normalizes provider-specific DTOs into the source-agnostic
/// [UnifiedTransaction]. Each `fromX` sets the provenance and maps the raw
/// category into the internal B2B taxonomy while preserving the original.
class UnifiedTransactionMapper {
  static UnifiedTransaction fromPlaid(
    PlaidTransaction source, {
    required String businessId,
    required DateTime date,
  }) {
    return UnifiedTransaction(
      businessId: businessId,
      transactionId: 'plaid-${source.transactionId}',
      externalId: source.transactionId,
      amount: source.amount,
      currency: source.isoCurrencyCode,
      date: date,
      merchantName: source.merchantName,
      source: TransactionSource.plaid,
      category: TransactionCategoryMapper.fromPlaid(source.category),
      rawCategory: source.category,
    );
  }
}
