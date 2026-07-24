import 'package:flutter/foundation.dart';
import 'package:growth_pilot_ai/core/models/pl_category_breakdown.dart';

/// A profit-and-loss summary for one accounting period (Issue #355):
/// total income, total expense broken down by category (sorted highest
/// first), and the resulting net profit.
@immutable
class PLSummary {
  final double totalIncome;
  final double totalExpense;
  final List<PLCategoryBreakdown> expenseByCategory;

  const PLSummary({
    required this.totalIncome,
    required this.totalExpense,
    required this.expenseByCategory,
  });

  double get netProfit => totalIncome - totalExpense;
}
