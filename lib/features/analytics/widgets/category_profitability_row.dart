import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/category_profitability.dart';
import 'package:growth_pilot_ai/core/utils/currency_format.dart';

/// One ranked row in the profitability breakdown (Issue #361): a bar sized
/// relative to [maxAbs], colored primary for a top revenue driver and
/// error for a loss-making category.
class CategoryProfitabilityRow extends StatelessWidget {
  final CategoryProfitability item;
  final double maxAbs;

  const CategoryProfitabilityRow(
      {super.key, required this.item, required this.maxAbs});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isLoss = item.netProfit < 0;
    final color = isLoss ? scheme.error : scheme.primary;
    final fraction =
        maxAbs <= 0 ? 0.0 : (item.netProfit.abs() / maxAbs).clamp(0.0, 1.0);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: Text(item.categoryName,
                      overflow: TextOverflow.ellipsis)),
              Text(CurrencyFormat.cad(item.netProfit),
                  style: TextStyle(color: color, fontWeight: FontWeight.w600)),
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
