import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/overhead_category.dart';
import 'package:growth_pilot_ai/core/utils/currency_format.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/overhead_category_label.dart';

/// One ranked row in the overhead breakdown (Issue #367): a bar sized by
/// [item.ratioToRevenue], with a warning icon when [item.isOverBudget].
class OverheadCategoryRow extends StatelessWidget {
  final OverheadCategory item;

  const OverheadCategoryRow({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color = item.isOverBudget ? scheme.error : scheme.primary;
    final fraction = item.ratioToRevenue.clamp(0.0, 1.0);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: OverheadCategoryLabel(
                  categoryName: item.categoryName,
                  isOverBudget: item.isOverBudget,
                  color: color,
                ),
              ),
              Text(
                '${(item.ratioToRevenue * 100).toStringAsFixed(1)}% '
                '(${CurrencyFormat.cad(item.expense)})',
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
