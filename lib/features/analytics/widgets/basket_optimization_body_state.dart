import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/compute_basket_optimization.dart';
import 'package:growth_pilot_ai/core/models/turnover_period.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/basket_optimization_body.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/basket_optimization_view.dart';

/// State for [BasketOptimizationBody] (Issue #390): recomputes the
/// optimization plan for the selected period.
class BasketOptimizationBodyState extends State<BasketOptimizationBody> {
  TurnoverPeriod _period = TurnoverPeriod.last90;

  @override
  Widget build(BuildContext context) {
    final snapshots = ComputeBasketOptimization.call(
      widget.items,
      widget.movements,
      widget.layers,
      DateTime.now(),
      _period.duration,
    );

    return BasketOptimizationView(
      period: _period,
      onPeriodChanged: (p) => setState(() => _period = p ?? _period),
      snapshots: snapshots,
    );
  }
}
