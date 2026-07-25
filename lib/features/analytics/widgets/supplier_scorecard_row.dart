import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/supplier_scorecard.dart';
import 'package:growth_pilot_ai/core/utils/currency_format.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/supplier_scorecard_label.dart';

/// One ranked supplier row (Issue #369): a bar sized by total spend
/// relative to [maxSpend], with the average price per transaction shown
/// on the right.
class SupplierScorecardRow extends StatelessWidget {
  final SupplierScorecard item;
  final double maxSpend;

  const SupplierScorecardRow({super.key, required this.item, required this.maxSpend});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color = item.isRecommended ? scheme.primary : scheme.onSurface;
    final fraction =
        maxSpend <= 0 ? 0.0 : (item.totalSpend / maxSpend).clamp(0.0, 1.0);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SupplierScorecardLabel(
                  vendorName: item.vendorName,
                  priceTrend: item.priceTrend,
                  isRecommended: item.isRecommended,
                ),
              ),
              Text(
                '${CurrencyFormat.cad(item.averageAmount)}/tx',
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
              color: scheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
