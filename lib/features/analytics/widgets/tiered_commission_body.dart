import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/wholesale_order_entity.dart';
import 'package:growth_pilot_ai/core/enum/commission_tier_band.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/tiered_commission_actions.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/tiered_commission_repos.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/tiered_commission_view.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/tiered_commission_view_state.dart';

/// Owns tiered-commission settlement state (Issue #425) — orders come
/// from the existing wholesale marketplace (#411) rather than a new
/// checkout flow.
class TieredCommissionBody extends StatefulWidget {
  const TieredCommissionBody({super.key});
  @override
  State<TieredCommissionBody> createState() => _TieredCommissionBodyState();
}

class _TieredCommissionBodyState extends State<TieredCommissionBody> {
  final _repos = TieredCommissionRepos();
  late final _actions = TieredCommissionActions(_repos);
  late TieredCommissionViewState _state = TieredCommissionViewState.load(_repos);

  void _reload() => setState(() => _state = TieredCommissionViewState.load(_repos));

  void _settle(WholesaleOrderEntity order) {
    _actions.settle(order);
    _reload();
  }

  void _setOverride(String merchantName, CommissionTierBand band) {
    _actions.setOverride(merchantName, band);
    _reload();
  }

  void _clearOverride(String merchantName) {
    _actions.clearOverride(merchantName);
    _reload();
  }

  @override
  Widget build(BuildContext context) {
    return TieredCommissionView(
      state: _state,
      onSettle: _settle,
      onSetOverride: _setOverride,
      onClearOverride: _clearOverride,
    );
  }
}
