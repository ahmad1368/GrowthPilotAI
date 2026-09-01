import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// The merchant/tier/fee/invoice fields for a new logged advanced-analytics
/// pricing tier assignment (Issue #336).
class AnalyticsPricingFields extends StatelessWidget {
  final TextEditingController merchantNameController;
  final TextEditingController tierNameController;
  final TextEditingController monthlyFeeController;
  final TextEditingController previousTierNameController;
  final TextEditingController previousMonthlyFeeController;
  final TextEditingController invoicedAmountController;

  const AnalyticsPricingFields({
    super.key,
    required this.merchantNameController,
    required this.tierNameController,
    required this.monthlyFeeController,
    required this.previousTierNameController,
    required this.previousMonthlyFeeController,
    required this.invoicedAmountController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShadInput(
            placeholder: const Text('Merchant name'),
            controller: merchantNameController),
        const SizedBox(height: 8),
        ShadInput(
            placeholder: const Text('New tier (e.g. Enterprise)'),
            controller: tierNameController),
        const SizedBox(height: 8),
        ShadInput(
            placeholder: const Text('New monthly fee'),
            controller: monthlyFeeController,
            keyboardType: TextInputType.number),
        const SizedBox(height: 8),
        ShadInput(
            placeholder: const Text('Previous tier (blank if new merchant)'),
            controller: previousTierNameController),
        const SizedBox(height: 8),
        ShadInput(
            placeholder: const Text('Previous monthly fee'),
            controller: previousMonthlyFeeController,
            keyboardType: TextInputType.number),
        const SizedBox(height: 8),
        ShadInput(
            placeholder: const Text('Invoiced amount settled'),
            controller: invoicedAmountController,
            keyboardType: TextInputType.number),
      ],
    );
  }
}
