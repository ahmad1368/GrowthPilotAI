import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// The name/discount-percent fields plus start/end date pickers for a new
/// discount campaign (Issue #362).
class DiscountCampaignFields extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController discountPercentController;
  final DateTime? startDate;
  final DateTime? endDate;
  final VoidCallback onPickStartDate;
  final VoidCallback onPickEndDate;

  const DiscountCampaignFields({
    super.key,
    required this.nameController,
    required this.discountPercentController,
    required this.startDate,
    required this.endDate,
    required this.onPickStartDate,
    required this.onPickEndDate,
  });

  String _label(DateTime? date, String placeholder) => date == null
      ? placeholder
      : '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    final fg = Theme.of(context).colorScheme.onSurface;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShadInput(
            placeholder: const Text('Campaign name'), controller: nameController),
        const SizedBox(height: 8),
        ShadInput(
            placeholder: const Text('Discount (%)'),
            controller: discountPercentController,
            keyboardType: TextInputType.number),
        const SizedBox(height: 8),
        ShadButton.outline(
          onPressed: onPickStartDate,
          child: Text(_label(startDate, 'Pick start date'), style: TextStyle(color: fg)),
        ),
        const SizedBox(height: 8),
        ShadButton.outline(
          onPressed: onPickEndDate,
          child: Text(_label(endDate, 'Pick end date'), style: TextStyle(color: fg)),
        ),
      ],
    );
  }
}
