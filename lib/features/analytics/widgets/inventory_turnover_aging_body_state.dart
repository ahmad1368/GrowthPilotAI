import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/compute_inventory_turnover_and_aging.dart';
import 'package:growth_pilot_ai/core/models/turnover_period.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/inventory_turnover_aging_body.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/inventory_turnover_aging_view.dart';

/// State for [InventoryTurnoverAgingBody] (Issue #447): recomputes
/// turnover/aging snapshots for the selected period.
class InventoryTurnoverAgingBodyState extends State<InventoryTurnoverAgingBody> {
  TurnoverPeriod _period = TurnoverPeriod.last90;

  @override
  Widget build(BuildContext context) {
    final snapshots = ComputeInventoryTurnoverAndAging.call(
      widget.items,
      widget.movements,
      widget.layers,
      DateTime.now(),
      _period.duration,
    );
    final averageTurnover = snapshots.isEmpty
        ? 0.0
        : snapshots.map((s) => s.turnoverRatio).reduce((a, b) => a + b) /
            snapshots.length;

    return InventoryTurnoverAgingView(
      period: _period,
      onPeriodChanged: (p) => setState(() => _period = p ?? _period),
      sector: widget.sector,
      averageTurnover: averageTurnover,
      snapshots: snapshots,
    );
  }
}
