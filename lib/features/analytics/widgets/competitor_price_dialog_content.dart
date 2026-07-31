import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/competitor_price_observation_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/competitor_price_fields.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Stateful form body for [showCompetitorPriceDialog] (Issue #351): owns
/// the text controllers and picked observation date.
class CompetitorPriceDialogContent extends StatefulWidget {
  const CompetitorPriceDialogContent({super.key});

  @override
  State<CompetitorPriceDialogContent> createState() =>
      _CompetitorPriceDialogContentState();
}

class _CompetitorPriceDialogContentState
    extends State<CompetitorPriceDialogContent> {
  final _productController = TextEditingController();
  final _competitorController = TextEditingController();
  final _ourPriceController = TextEditingController();
  final _competitorPriceController = TextEditingController();
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
    final ourPrice = double.tryParse(_ourPriceController.text);
    final competitorPrice = double.tryParse(_competitorPriceController.text);
    if (_productController.text.trim().isEmpty ||
        _competitorController.text.trim().isEmpty ||
        ourPrice == null ||
        ourPrice < 0 ||
        competitorPrice == null ||
        competitorPrice < 0 ||
        _observedAt == null) {
      return;
    }
    Navigator.of(context).pop(CompetitorPriceObservationEntity(
      productName: _productController.text.trim(),
      competitorName: _competitorController.text.trim(),
      ourPrice: ourPrice,
      competitorPrice: competitorPrice,
      observedAt: _observedAt!,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return ShadDialog.alert(
      title: const Text('Log Competitor Price Check'),
      description: CompetitorPriceFields(
        productController: _productController,
        competitorController: _competitorController,
        ourPriceController: _ourPriceController,
        competitorPriceController: _competitorPriceController,
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
