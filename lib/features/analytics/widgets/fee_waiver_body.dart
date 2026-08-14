import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/fee_waiver_record_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/wholesale_order_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/fee_waiver_actions.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/fee_waiver_repos.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/fee_waiver_view.dart';

/// Owns fee-waiver record state for the zero-commission incentive
/// engine (Issue #420) — orders come from the existing wholesale
/// marketplace (#411) rather than a new checkout flow.
class FeeWaiverBody extends StatefulWidget {
  const FeeWaiverBody({super.key});
  @override
  State<FeeWaiverBody> createState() => _FeeWaiverBodyState();
}

class _FeeWaiverBodyState extends State<FeeWaiverBody> {
  final _repos = FeeWaiverRepos();
  late final _actions = FeeWaiverActions(_repos);
  late final List<WholesaleOrderEntity> _orders = _repos.orders.getAll();
  late List<FeeWaiverRecordEntity> _records = _repos.records.getAll();

  void _evaluate(WholesaleOrderEntity order) {
    _actions.evaluate(order);
    setState(() => _records = _repos.records.getAll());
  }

  @override
  Widget build(BuildContext context) {
    final anyMerchantHasWaiver = _records.any((r) => r.isWaived);
    return FeeWaiverView(
      orders: _orders,
      records: _records,
      showPromoBanner: !anyMerchantHasWaiver,
      onEvaluate: _evaluate,
    );
  }
}
