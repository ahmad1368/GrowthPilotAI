import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/budget_limit_dialog_content.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Quick-configure dialog for a category budget limit (Issue #383).
/// Returns a (categoryName, monthlyLimit) record, or null if
/// cancelled/invalid.
Future<(String, double)?> showBudgetLimitDialog(BuildContext context) {
  return showShadDialog<(String, double)>(
    context: context,
    builder: (context) => const BudgetLimitDialogContent(),
  );
}
