import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/merchant_dependency_actions.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/merchant_dependency_repos.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/merchant_dependency_view.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/merchant_dependency_view_state.dart';

/// Owns merchant-dependency evaluation state (Issue #424) — merchant
/// names come from the existing wholesale marketplace orders (#411)
/// rather than a new merchant directory.
class MerchantDependencyBody extends StatefulWidget {
  const MerchantDependencyBody({super.key});
  @override
  State<MerchantDependencyBody> createState() => _MerchantDependencyBodyState();
}

class _MerchantDependencyBodyState extends State<MerchantDependencyBody> {
  final _repos = MerchantDependencyRepos();
  late final _actions = MerchantDependencyActions(_repos);
  late MerchantDependencyViewState _state = MerchantDependencyViewState.load(_repos);

  void _reload() => setState(() => _state = MerchantDependencyViewState.load(_repos));

  void _logVisit(String merchantName) {
    _actions.logVisit(merchantName);
    _reload();
  }

  void _setLiquidation(String merchantName, double percent) {
    _actions.setLiquidationPercent(merchantName, percent);
    _reload();
  }

  void _evaluate(String merchantName) {
    _actions.evaluate(merchantName);
    _reload();
  }

  @override
  Widget build(BuildContext context) {
    return MerchantDependencyView(
      state: _state,
      onLogVisit: _logVisit,
      onSetLiquidation: _setLiquidation,
      onEvaluate: _evaluate,
    );
  }
}
