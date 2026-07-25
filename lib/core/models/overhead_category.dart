import 'package:flutter/foundation.dart';

/// One expense category's weight against total revenue (Issue #367).
/// [isOverBudget] flags categories past [ComputeOverheadBreakdown.alertThreshold]
/// — a documented default stand-in for a real per-category budget limit,
/// which this app has no data model for.
@immutable
class OverheadCategory {
  final String categoryName;
  final double expense;
  final double ratioToRevenue;
  final bool isOverBudget;

  const OverheadCategory({
    required this.categoryName,
    required this.expense,
    required this.ratioToRevenue,
    this.isOverBudget = false,
  });
}
