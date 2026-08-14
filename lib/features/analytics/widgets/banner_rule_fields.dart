import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Report topic/category/priority fields for a new banner matching
/// rule (Issue #403, acceptance criterion 4).
class BannerRuleFields extends StatelessWidget {
  final TextEditingController reportTopicController;
  final TextEditingController categoryController;
  final TextEditingController priorityWeightController;

  const BannerRuleFields({
    super.key,
    required this.reportTopicController,
    required this.categoryController,
    required this.priorityWeightController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShadInput(
            placeholder: const Text('Report topic (e.g. profit margin)'),
            controller: reportTopicController),
        const SizedBox(height: 8),
        ShadInput(
            placeholder: const Text('Matching promotion category'),
            controller: categoryController),
        const SizedBox(height: 8),
        ShadInput(
            placeholder: const Text('Priority weight'),
            controller: priorityWeightController,
            keyboardType: TextInputType.number),
      ],
    );
  }
}
