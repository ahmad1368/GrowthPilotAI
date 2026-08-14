import 'package:flutter/foundation.dart';

/// Net profit contribution for one category (Issue #361) — the closest
/// local proxy for "item/service-level profitability" this app's data
/// model has, since transactions aren't tied to individual SKUs.
@immutable
class CategoryProfitability {
  final String categoryName;
  final double income;
  final double expense;

  const CategoryProfitability({
    required this.categoryName,
    required this.income,
    required this.expense,
  });

  double get netProfit => income - expense;
}
