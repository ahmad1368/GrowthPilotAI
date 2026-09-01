import 'package:growth_pilot_ai/business/group_transactions_by_customer.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/models/revenue_dependency_snapshot.dart';

/// Revenue reliance on repeat buyers vs one-time buyers, plus a
/// single-account concentration-risk flag (Issue #376).
class ComputeRevenueDependencySnapshot {
  static const concentrationThreshold = 0.3;

  static RevenueDependencySnapshot call(List<TransactionEntity> transactions) {
    final groups = GroupTransactionsByCustomer.call(transactions);
    final totalRevenue =
        groups.fold<double>(0, (sum, g) => sum + g.totalRevenue);
    final repeatGroups = groups.where((g) => g.isRepeat);
    final oneTimeGroups = groups.where((g) => !g.isRepeat);
    final repeatRevenue =
        repeatGroups.fold<double>(0, (sum, g) => sum + g.totalRevenue);
    final topGroup = groups.isEmpty ? null : groups.first;
    final topCustomerShare =
        totalRevenue <= 0 || topGroup == null ? 0.0 : topGroup.totalRevenue / totalRevenue;

    return RevenueDependencySnapshot(
      totalRevenue: totalRevenue,
      repeatRevenue: repeatRevenue,
      oneTimeRevenue: totalRevenue - repeatRevenue,
      repeatRevenueShare: totalRevenue <= 0 ? 0.0 : repeatRevenue / totalRevenue,
      repeatCustomerCount: repeatGroups.length,
      oneTimeCustomerCount: oneTimeGroups.length,
      topCustomerLabel: topGroup?.label,
      topCustomerShare: topCustomerShare,
      isConcentrationRisk: topCustomerShare >= concentrationThreshold,
    );
  }
}
