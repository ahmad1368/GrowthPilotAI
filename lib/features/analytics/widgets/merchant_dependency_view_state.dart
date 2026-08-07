import 'package:growth_pilot_ai/core/data/entities/merchant_dependency_evaluation_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/merchant_dependency_repos.dart';

/// Snapshot of everything [MerchantDependencyView] needs to render,
/// loaded in one pass from [MerchantDependencyRepos] (Issue #424) —
/// keeps the merchant-name/evaluation/liquidation-percent lookups out
/// of [MerchantDependencyBody] itself.
class MerchantDependencyViewState {
  final List<String> merchantNames;
  final Map<String, MerchantDependencyEvaluationEntity?> latestEvaluations;
  final Map<String, double> liquidationPercent;

  const MerchantDependencyViewState({
    required this.merchantNames,
    required this.latestEvaluations,
    required this.liquidationPercent,
  });

  factory MerchantDependencyViewState.load(MerchantDependencyRepos repos) {
    final names = repos.orders.getAll().map((o) => o.buyerMerchantName).toSet().toList()..sort();
    return MerchantDependencyViewState(
      merchantNames: names,
      latestEvaluations: {for (final n in names) n: repos.evaluations.latestForMerchant(n)},
      liquidationPercent: {
        for (final n in names) n: repos.inputs.forMerchant(n)?.inventoryLiquidationPercent ?? 0,
      },
    );
  }
}
