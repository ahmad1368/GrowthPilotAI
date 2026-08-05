import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Subject and audience segmentation text fields for a new campaign
/// (Issue #407, acceptance criterion 2).
class MarketingCampaignFields extends StatelessWidget {
  final TextEditingController subjectController;
  final TextEditingController categoryController;
  final TextEditingController regionController;

  const MarketingCampaignFields({
    super.key,
    required this.subjectController,
    required this.categoryController,
    required this.regionController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShadInput(
            placeholder: const Text('Subject line'),
            controller: subjectController),
        const SizedBox(height: 8),
        ShadInput(
            placeholder: const Text('Segment category (e.g. Grocery)'),
            controller: categoryController),
        const SizedBox(height: 8),
        ShadInput(
            placeholder: const Text('Segment region (optional)'),
            controller: regionController),
      ],
    );
  }
}
