import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/category_elasticity.dart';
import 'package:growth_pilot_ai/core/utils/currency_format.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/category_elasticity_label.dart';

/// One category's price-elasticity row (Issue #380): label + average price.
class CategoryElasticityRow extends StatelessWidget {
  final CategoryElasticity item;

  const CategoryElasticityRow({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: CategoryElasticityLabel(item: item)),
          Text(
            '${CurrencyFormat.cad(item.averagePrice)} avg',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
