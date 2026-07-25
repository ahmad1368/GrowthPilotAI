import 'package:objectbox/objectbox.dart';

/// A merchant-configured monthly spending ceiling for one category (Issue
/// #383) — the real per-category budget limit the overhead widget (#367)
/// flagged as missing, replacing its hardcoded 15%-of-revenue heuristic.
@Entity()
class BudgetLimitEntity {
  @Id()
  int id = 0;

  @Unique()
  String categoryName;

  double monthlyLimit;

  BudgetLimitEntity({
    this.id = 0,
    required this.categoryName,
    required this.monthlyLimit,
  });
}
