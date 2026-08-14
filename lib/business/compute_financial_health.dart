import 'package:growth_pilot_ai/core/data/entities/linked_account_entity.dart';
import 'package:growth_pilot_ai/core/models/financial_health.dart';

/// Computes a current-ratio-based financial health score from linked
/// account balances (Issue #385): depository accounts as current assets,
/// credit accounts as current liabilities — the closest real balance-sheet
/// data this app tracks. No inventory concept exists, so this doubles as a
/// "quick ratio" too (nothing to subtract). A ratio of 2.0+ maps to a full
/// 100 score, a common textbook "healthy" threshold.
class ComputeFinancialHealth {
  static FinancialHealth call(List<LinkedAccountEntity> accounts) {
    final active = accounts.where((a) => a.isActive);
    final assets = active
        .where((a) => a.accountType == 'depository')
        .fold(0.0, (sum, a) => sum + a.currentBalance);
    final liabilities = active
        .where((a) => a.accountType == 'credit')
        .fold(0.0, (sum, a) => sum + a.currentBalance);

    final ratio = liabilities <= 0 ? (assets > 0 ? 2.0 : 0.0) : assets / liabilities;
    final score = (ratio / 2.0 * 100).clamp(0, 100).round();

    return FinancialHealth(
      currentAssets: assets,
      currentLiabilities: liabilities,
      workingCapital: assets - liabilities,
      currentRatio: ratio,
      healthScore: score,
    );
  }
}
