import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/cash_flow_projection.dart';
import 'package:growth_pilot_ai/core/utils/currency_format.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/cash_flow_month_label.dart';

/// One projected month in the cash-flow forecast (Issue #368): a bar sized
/// relative to [maxAbs], colored error for a projected deficit month.
class CashFlowForecastRow extends StatelessWidget {
  final CashFlowProjection item;
  final double maxAbs;

  const CashFlowForecastRow({super.key, required this.item, required this.maxAbs});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color = item.isDeficit ? scheme.error : scheme.primary;
    final fraction =
        maxAbs <= 0 ? 0.0 : (item.projectedNet.abs() / maxAbs).clamp(0.0, 1.0);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: CashFlowMonthLabel(
                  monthLabel: item.monthLabel,
                  isDeficit: item.isDeficit,
                  color: color,
                ),
              ),
              Text(
                CurrencyFormat.cad(item.projectedNet),
                style: TextStyle(color: color, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 4),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: fraction,
              minHeight: 6,
              backgroundColor: scheme.onSurface.withValues(alpha: 0.08),
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
