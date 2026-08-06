import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/price_query_controller.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// SKU/candidate-price input row for the Fair Price Index query
/// (Issue #416, acceptance criterion 1).
class PriceQueryFields extends StatelessWidget {
  final PriceQueryController query;
  final VoidCallback onCheck;

  const PriceQueryFields({super.key, required this.query, required this.onCheck});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
          child: ShadInput(
              placeholder: const Text('Product/SKU name'), controller: query.productName)),
      const SizedBox(width: 4),
      SizedBox(
        width: 110,
        child: ShadInput(
            placeholder: const Text('Listing \$'),
            controller: query.candidatePrice,
            keyboardType: TextInputType.number),
      ),
      const SizedBox(width: 4),
      ShadButton.ghost(onPressed: onCheck, child: const Text('Check Price')),
    ]);
  }
}
