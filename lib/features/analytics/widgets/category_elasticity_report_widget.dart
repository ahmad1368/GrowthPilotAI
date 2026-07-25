import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/compute_category_elasticity.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/category_elasticity_row.dart';

/// Registers the Service Price Elasticity widget (Issue #380) as a
/// pluggable report widget under id `CATEGORY_ELASTICITY` (#111): each
/// category's average price alongside a historical price-vs-volume
/// correlation hint.
class CategoryElasticityReportWidget extends BaseReportWidget {
  const CategoryElasticityReportWidget(
      {super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    final items = ComputeCategoryElasticity.call(
        data['transactions'] as List<TransactionEntity>);
    if (items.isEmpty) {
      return const Text('No categorized revenue yet.');
    }
    final scheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Warning icon = raising price lost volume. Check = price held steady.',
          style: TextStyle(fontSize: 12, color: scheme.onSurface.withValues(alpha: 0.6)),
        ),
        const SizedBox(height: 8),
        for (final item in items) CategoryElasticityRow(item: item),
      ],
    );
  }
}
