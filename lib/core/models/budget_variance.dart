import 'package:flutter/foundation.dart';

/// One category's configured limit vs. actual spend this period (Issue
/// #383).
@immutable
class BudgetVariance {
  final String categoryName;
  final double limit;
  final double actualSpend;

  const BudgetVariance({
    required this.categoryName,
    required this.limit,
    required this.actualSpend,
  });

  bool get isOverBudget => actualSpend > limit;

  double get variancePercent =>
      limit <= 0 ? 0.0 : ((actualSpend - limit) / limit) * 100;
}
