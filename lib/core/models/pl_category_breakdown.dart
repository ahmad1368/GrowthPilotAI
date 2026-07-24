import 'package:flutter/foundation.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';

/// One expense category's total plus its line items (Issue #355), so the
/// P&L report can drill down from a category total to the transactions
/// behind it.
@immutable
class PLCategoryBreakdown {
  final String categoryName;
  final double total;
  final List<TransactionEntity> transactions;

  const PLCategoryBreakdown({
    required this.categoryName,
    required this.total,
    required this.transactions,
  });
}
