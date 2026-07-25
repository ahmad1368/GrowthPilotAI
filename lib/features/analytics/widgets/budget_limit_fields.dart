import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// The 2 input fields for setting a budget limit (Issue #383): category
/// name and the monthly ceiling amount.
class BudgetLimitFields extends StatelessWidget {
  final TextEditingController categoryController;
  final TextEditingController limitController;

  const BudgetLimitFields({
    super.key,
    required this.categoryController,
    required this.limitController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShadInput(
            placeholder: const Text('Category name'), controller: categoryController),
        const SizedBox(height: 8),
        ShadInput(
            placeholder: const Text('Monthly limit (\$)'),
            controller: limitController,
            keyboardType: TextInputType.number),
      ],
    );
  }
}
