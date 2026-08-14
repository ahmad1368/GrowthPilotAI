import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/merchant_dependency_merchant_row.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/merchant_dependency_view_state.dart';

/// Renders one row per marketplace merchant with their latest
/// dependency evaluation (Issue #424). Purely presentational.
class MerchantDependencyView extends StatelessWidget {
  final MerchantDependencyViewState state;
  final void Function(String) onLogVisit;
  final void Function(String, double) onSetLiquidation;
  final void Function(String) onEvaluate;

  const MerchantDependencyView({
    super.key,
    required this.state,
    required this.onLogVisit,
    required this.onSetLiquidation,
    required this.onEvaluate,
  });

  @override
  Widget build(BuildContext context) {
    if (state.merchantNames.isEmpty) {
      return const Text(
        'No marketplace merchants yet — dependency signals build up as '
        'orders and activity are logged.',
        style: TextStyle(fontSize: 12),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final name in state.merchantNames)
          MerchantDependencyMerchantRow(
            merchantName: name,
            evaluation: state.latestEvaluations[name],
            liquidationPercent: state.liquidationPercent[name] ?? 0,
            onLogVisit: () => onLogVisit(name),
            onSetLiquidation: (v) => onSetLiquidation(name, v),
            onEvaluate: () => onEvaluate(name),
          ),
      ],
    );
  }
}
