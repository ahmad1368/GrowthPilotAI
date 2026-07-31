import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// The product/competitor/price fields plus observed-date picker for a
/// new competitor price observation (Issue #351).
class CompetitorPriceFields extends StatelessWidget {
  final TextEditingController productController;
  final TextEditingController competitorController;
  final TextEditingController ourPriceController;
  final TextEditingController competitorPriceController;
  final DateTime? observedAt;
  final VoidCallback onPickDate;

  const CompetitorPriceFields({
    super.key,
    required this.productController,
    required this.competitorController,
    required this.ourPriceController,
    required this.competitorPriceController,
    required this.observedAt,
    required this.onPickDate,
  });

  String _label(DateTime? d, String placeholder) => d == null
      ? placeholder
      : '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    final fg = Theme.of(context).colorScheme.onSurface;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShadInput(
            placeholder: const Text('Product name'), controller: productController),
        const SizedBox(height: 8),
        ShadInput(
            placeholder: const Text('Competitor name'),
            controller: competitorController),
        const SizedBox(height: 8),
        ShadInput(
            placeholder: const Text('Our price (\$)'),
            controller: ourPriceController,
            keyboardType: TextInputType.number),
        const SizedBox(height: 8),
        ShadInput(
            placeholder: const Text('Competitor price (\$)'),
            controller: competitorPriceController,
            keyboardType: TextInputType.number),
        const SizedBox(height: 8),
        ShadButton.outline(
          onPressed: onPickDate,
          child: Text(_label(observedAt, 'Pick observation date'),
              style: TextStyle(color: fg)),
        ),
      ],
    );
  }
}
