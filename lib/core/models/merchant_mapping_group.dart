import 'package:flutter/foundation.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/models/mapping_result.dart';

/// One row in the Category Mapping screen: a merchant's uncategorized
/// transactions batched together with the mapping engine's suggestion
/// (Issue #58 — Category Mapping Interface).
@immutable
class MerchantMappingGroup {
  final String merchantName;
  final List<TransactionEntity> transactions;
  final MappingResult mapping;

  const MerchantMappingGroup({
    required this.merchantName,
    required this.transactions,
    required this.mapping,
  });

  double get totalAmount =>
      transactions.fold(0.0, (sum, t) => sum + t.amount);

  int get transactionCount => transactions.length;
}
