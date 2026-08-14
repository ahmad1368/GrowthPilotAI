import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/models/space_productivity_result.dart';

/// Computes revenue-per-square-foot from local income transactions and the
/// user-entered store floor space (Issue #398). No per-zone/display-area
/// sales breakdown exists in this app's data model, so the index is
/// store-wide only — see [SpaceProductivityReportWidget] for the documented
/// scope-down from the original per-zone "layout optimization" ask.
class ComputeSpaceProductivity {
  static SpaceProductivityResult call(
      List<TransactionEntity> transactions, double squareFootage) {
    final totalRevenue = transactions
        .where((t) => t.type == TransactionType.income)
        .fold(0.0, (sum, t) => sum + t.amount);
    final perSquareFoot = squareFootage > 0 ? totalRevenue / squareFootage : 0.0;

    return SpaceProductivityResult(
      totalRevenue: totalRevenue,
      squareFootage: squareFootage,
      revenuePerSquareFoot: double.parse(perSquareFoot.toStringAsFixed(2)),
    );
  }
}
