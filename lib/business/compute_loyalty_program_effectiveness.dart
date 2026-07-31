import 'package:growth_pilot_ai/business/group_transactions_by_customer.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/models/loyalty_program_effectiveness.dart';

/// Simulates a standard 1-point-per-dollar loyalty program (Issue #396) —
/// this app runs no real points ledger, so [pointsIssued]/[liabilityCost]
/// are a documented assumption, mirroring the mocked-benchmark idiom
/// already used by [GetSectorBenchmark] and [canadianStatutoryHolidays].
/// Reuses [GroupTransactionsByCustomer] (#376) to value the repeat-buyer
/// base the program is meant to protect.
class ComputeLoyaltyProgramEffectiveness {
  static const redemptionValuePerPoint = 0.01;
  static const effectivenessThreshold = 5.0;

  static LoyaltyProgramEffectiveness call(List<TransactionEntity> transactions) {
    final groups = GroupTransactionsByCustomer.call(transactions);
    final totalRevenue = groups.fold<double>(0, (sum, g) => sum + g.totalRevenue);
    final repeatCustomerRevenue = groups
        .where((g) => g.isRepeat)
        .fold<double>(0, (sum, g) => sum + g.totalRevenue);

    final pointsIssued = totalRevenue.round();
    final liabilityCost = pointsIssued * redemptionValuePerPoint;
    final roiRatio = liabilityCost <= 0 ? 0.0 : repeatCustomerRevenue / liabilityCost;

    return LoyaltyProgramEffectiveness(
      pointsIssued: pointsIssued,
      liabilityCost: liabilityCost,
      repeatCustomerRevenue: repeatCustomerRevenue,
      roiRatio: roiRatio,
      isEffective: roiRatio >= effectivenessThreshold,
    );
  }
}
