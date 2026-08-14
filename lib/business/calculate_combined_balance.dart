import 'package:growth_pilot_ai/core/data/entities/linked_account_entity.dart';

/// Sums [LinkedAccountEntity.currentBalance] across active accounts only
/// (Issue #68 — the "Total Combined Balance" header must reflect exactly
/// what's actually being tracked, not disabled accounts).
class CalculateCombinedBalance {
  static double call(List<LinkedAccountEntity> accounts) => accounts
      .where((a) => a.isActive)
      .fold(0.0, (sum, a) => sum + a.currentBalance);
}
