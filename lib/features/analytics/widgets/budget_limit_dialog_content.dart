import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/budget_limit_fields.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Stateful form body for [showBudgetLimitDialog] (Issue #383): owns the
/// text controllers, returns a (categoryName, monthlyLimit) record.
class BudgetLimitDialogContent extends StatefulWidget {
  const BudgetLimitDialogContent({super.key});

  @override
  State<BudgetLimitDialogContent> createState() => _BudgetLimitDialogContentState();
}

class _BudgetLimitDialogContentState extends State<BudgetLimitDialogContent> {
  final _categoryController = TextEditingController();
  final _limitController = TextEditingController();

  void _submit() {
    final name = _categoryController.text.trim();
    final limit = double.tryParse(_limitController.text);
    if (name.isEmpty || limit == null || limit <= 0) return;
    Navigator.of(context).pop((name, limit));
  }

  @override
  Widget build(BuildContext context) {
    return ShadDialog.alert(
      title: const Text('Set Budget Limit'),
      description: BudgetLimitFields(
        categoryController: _categoryController,
        limitController: _limitController,
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
