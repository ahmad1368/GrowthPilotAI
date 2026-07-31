import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// The currency-pair/product/rate fields plus observed-date picker for a
/// new FX rate observation (Issue #371).
class ExchangeRateFields extends StatelessWidget {
  final TextEditingController currencyPairController;
  final TextEditingController productController;
  final TextEditingController baselineRateController;
  final TextEditingController currentRateController;
  final TextEditingController importCostController;
  final DateTime? observedAt;
  final VoidCallback onPickDate;

  const ExchangeRateFields({
    super.key,
    required this.currencyPairController,
    required this.productController,
    required this.baselineRateController,
    required this.currentRateController,
    required this.importCostController,
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
            placeholder: const Text('Currency pair (e.g. USD/CAD)'),
            controller: currencyPairController),
        const SizedBox(height: 8),
        ShadInput(
            placeholder: const Text('Imported product name'),
            controller: productController),
        const SizedBox(height: 8),
        ShadInput(
            placeholder: const Text('Baseline rate'),
            controller: baselineRateController,
            keyboardType: TextInputType.number),
        const SizedBox(height: 8),
        ShadInput(
            placeholder: const Text('Current rate'),
            controller: currentRateController,
            keyboardType: TextInputType.number),
        const SizedBox(height: 8),
        ShadInput(
            placeholder: const Text('Import cost (foreign currency, \$)'),
            controller: importCostController,
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
