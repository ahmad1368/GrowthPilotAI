import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/models/pl_category_breakdown.dart';
import 'package:growth_pilot_ai/core/models/pl_summary.dart';

/// Builds a P&L summary from local transactions (Issue #355): categorized
/// expense breakdown, sorted highest-total first, so the biggest cost
/// drivers surface immediately. No double-entry ledger — this app's
/// transactions are already a flat income/expense stream, not journal
/// entries with debit/credit pairs.
class ComputePLSummary {
  static PLSummary call(List<TransactionEntity> transactions) {
    final income = transactions
        .where((t) => t.type == TransactionType.income)
        .fold(0.0, (sum, t) => sum + t.amount);
    final expenses =
        transactions.where((t) => t.type == TransactionType.expense).toList();

    final byCategory = <String, List<TransactionEntity>>{};
    for (final t in expenses) {
      final name = t.category.target?.name ?? 'Uncategorized';
      (byCategory[name] ??= []).add(t);
    }

    final breakdown = byCategory.entries
        .map((e) => PLCategoryBreakdown(
              categoryName: e.key,
              total: e.value.fold(0.0, (sum, t) => sum + t.amount),
              transactions: e.value,
            ))
        .toList()
      ..sort((a, b) => b.total.compareTo(a.total));

    return PLSummary(
      totalIncome: income,
      totalExpense: expenses.fold(0.0, (sum, t) => sum + t.amount),
      expenseByCategory: breakdown,
    );
  }
}
