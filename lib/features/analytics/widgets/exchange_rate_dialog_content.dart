import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/exchange_rate_observation_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/exchange_rate_fields.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Stateful form body for [showExchangeRateDialog] (Issue #371): owns the
/// text controllers and picked observation date.
class ExchangeRateDialogContent extends StatefulWidget {
  const ExchangeRateDialogContent({super.key});

  @override
  State<ExchangeRateDialogContent> createState() =>
      _ExchangeRateDialogContentState();
}

class _ExchangeRateDialogContentState
    extends State<ExchangeRateDialogContent> {
  final _currencyPairController = TextEditingController();
  final _productController = TextEditingController();
  final _baselineRateController = TextEditingController();
  final _currentRateController = TextEditingController();
  final _importCostController = TextEditingController();
  DateTime? _observedAt;

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _observedAt ?? DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 3650)),
      lastDate: DateTime.now().add(const Duration(days: 1)),
    );
    if (picked != null) setState(() => _observedAt = picked);
  }

  void _submit() {
    final baselineRate = double.tryParse(_baselineRateController.text);
    final currentRate = double.tryParse(_currentRateController.text);
    final importCost = double.tryParse(_importCostController.text);
    if (_currencyPairController.text.trim().isEmpty ||
        _productController.text.trim().isEmpty ||
        baselineRate == null ||
        baselineRate <= 0 ||
        currentRate == null ||
        currentRate <= 0 ||
        importCost == null ||
        importCost < 0 ||
        _observedAt == null) {
      return;
    }
    Navigator.of(context).pop(ExchangeRateObservationEntity(
      currencyPair: _currencyPairController.text.trim(),
      productName: _productController.text.trim(),
      baselineRate: baselineRate,
      currentRate: currentRate,
      importCostForeign: importCost,
      observedAt: _observedAt!,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return ShadDialog.alert(
      title: const Text('Log Exchange Rate Check'),
      description: ExchangeRateFields(
        currencyPairController: _currencyPairController,
        productController: _productController,
        baselineRateController: _baselineRateController,
        currentRateController: _currentRateController,
        importCostController: _importCostController,
        observedAt: _observedAt,
        onPickDate: _pickDate,
      ),
      actions: [
        ShadButton.outline(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ShadButton(onPressed: _submit, child: const Text('Save')),
      ],
    );
  }
}
