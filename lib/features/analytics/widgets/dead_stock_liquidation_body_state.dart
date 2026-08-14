import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/compute_dead_stock_liquidation.dart';
import 'package:growth_pilot_ai/core/models/turnover_period.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/dead_stock_liquidation_body.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/dead_stock_liquidation_view.dart';

/// State for [DeadStockLiquidationBody] (Issue #370): recomputes the
/// liquidation plan for the selected period.
class DeadStockLiquidationBodyState extends State<DeadStockLiquidationBody> {
  TurnoverPeriod _period = TurnoverPeriod.last90;

  @override
  Widget build(BuildContext context) {
    final snapshots = ComputeDeadStockLiquidation.call(
      widget.items,
      widget.movements,
      widget.layers,
      DateTime.now(),
      _period.duration,
    );

    return DeadStockLiquidationView(
      period: _period,
      onPeriodChanged: (p) => setState(() => _period = p ?? _period),
      snapshots: snapshots,
    );
  }
}
