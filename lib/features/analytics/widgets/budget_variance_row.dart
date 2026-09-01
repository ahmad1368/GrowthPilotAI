import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/budget_variance.dart';
import 'package:growth_pilot_ai/core/utils/currency_format.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/budget_category_label.dart';

/// One category's budget-vs-actual row (Issue #383): a bar sized by spend
/// relative to the limit, colored error when over budget.
class BudgetVarianceRow extends StatelessWidget {
  final BudgetVariance item;

  const BudgetVarianceRow({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color = item.isOverBudget ? scheme.error : scheme.primary;
    final fraction =
        item.limit <= 0 ? 0.0 : (item.actualSpend / item.limit).clamp(0.0, 1.0);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: BudgetCategoryLabel(
                  categoryName: item.categoryName,
                  isOverBudget: item.isOverBudget,
                  color: color,
                ),
              ),
              Text(
                '${CurrencyFormat.cad(item.actualSpend)} / ${CurrencyFormat.cad(item.limit)}',
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
