import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// The partner name/category/overlap-score/revenue/referral-count fields
/// plus partnered-date picker for a new partnership (Issue #393).
class MerchantPartnershipFields extends StatelessWidget {
  final TextEditingController partnerNameController;
  final TextEditingController partnerCategoryController;
  final TextEditingController overlapScoreController;
  final TextEditingController campaignRevenueController;
  final TextEditingController referralCountController;
  final DateTime? partneredAt;
  final VoidCallback onPickDate;

  const MerchantPartnershipFields({
    super.key,
    required this.partnerNameController,
    required this.partnerCategoryController,
    required this.overlapScoreController,
    required this.campaignRevenueController,
    required this.referralCountController,
    required this.partneredAt,
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
            placeholder: const Text('Partner business name'),
            controller: partnerNameController),
        const SizedBox(height: 8),
        ShadInput(
            placeholder: const Text('Partner category (e.g. cafe, gym)'),
            controller: partnerCategoryController),
        const SizedBox(height: 8),
        ShadInput(
            placeholder: const Text('Customer overlap score (0-100)'),
            controller: overlapScoreController,
            keyboardType: TextInputType.number),
        const SizedBox(height: 8),
        ShadInput(
            placeholder: const Text('Joint campaign revenue (\$)'),
            controller: campaignRevenueController,
            keyboardType: TextInputType.number),
        const SizedBox(height: 8),
        ShadInput(
            placeholder: const Text('Joint referral count'),
            controller: referralCountController,
            keyboardType: TextInputType.number),
        const SizedBox(height: 8),
        ShadButton.outline(
          onPressed: onPickDate,
          child: Text(_label(partneredAt, 'Pick partnered date'),
              style: TextStyle(color: fg)),
        ),
      ],
    );
  }
}
