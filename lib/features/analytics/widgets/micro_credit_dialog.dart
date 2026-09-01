import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/micro_credit_dialog_content.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Checkout financing selection wizard (Issue #419, acceptance
/// criterion 2). Returns the requested draw's terms, or null if
/// cancelled/invalid.
typedef MicroCreditRequest = ({
  String sellerName,
  String itemDescription,
  double principal,
  int termDays,
});

Future<MicroCreditRequest?> showMicroCreditDialog(BuildContext context) {
  return showShadDialog<MicroCreditRequest>(
    context: context,
    builder: (context) => const MicroCreditDialogContent(),
  );
}
