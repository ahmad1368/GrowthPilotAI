import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/analytics_pricing_tier_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/analytics_pricing_fields.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Stateful form body for [showAnalyticsPricingDialog] (Issue #336): owns
/// the text controllers for the new tier assignment.
class AnalyticsPricingDialogContent extends StatefulWidget {
  const AnalyticsPricingDialogContent({super.key});

  @override
  State<AnalyticsPricingDialogContent> createState() =>
      _AnalyticsPricingDialogContentState();
}

class _AnalyticsPricingDialogContentState
    extends State<AnalyticsPricingDialogContent> {
  final _merchantNameController = TextEditingController();
  final _tierNameController = TextEditingController();
  final _monthlyFeeController = TextEditingController();
  final _previousTierNameController = TextEditingController();
  final _previousMonthlyFeeController = TextEditingController();
  final _invoicedAmountController = TextEditingController();

  void _submit() {
    final monthlyFee = double.tryParse(_monthlyFeeController.text);
    final previousMonthlyFee =
        double.tryParse(_previousMonthlyFeeController.text) ?? 0;
    final invoicedAmount = double.tryParse(_invoicedAmountController.text);
    if (_merchantNameController.text.trim().isEmpty ||
        _tierNameController.text.trim().isEmpty ||
        monthlyFee == null ||
        monthlyFee < 0 ||
        invoicedAmount == null ||
        invoicedAmount < 0) {
      return;
    }
    Navigator.of(context).pop(AnalyticsPricingTierEntity(
      merchantName: _merchantNameController.text.trim(),
      tierName: _tierNameController.text.trim(),
      monthlyFee: monthlyFee,
      previousTierName: _previousTierNameController.text.trim(),
      previousMonthlyFee: previousMonthlyFee,
      invoicedAmount: invoicedAmount,
      effectiveAt: DateTime.now(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return ShadDialog.alert(
      title: const Text('Assign Pricing Tier'),
      description: AnalyticsPricingFields(
        merchantNameController: _merchantNameController,
        tierNameController: _tierNameController,
        monthlyFeeController: _monthlyFeeController,
        previousTierNameController: _previousTierNameController,
        previousMonthlyFeeController: _previousMonthlyFeeController,
        invoicedAmountController: _invoicedAmountController,
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
