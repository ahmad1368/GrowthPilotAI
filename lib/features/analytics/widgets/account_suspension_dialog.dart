import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/account_suspension_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/account_suspension_dialog_content.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Quick-add form for suspending a merchant account (Issue #341).
/// Returns the new suspension record (not yet persisted) or null if
/// cancelled/invalid.
Future<AccountSuspensionEntity?> showAccountSuspensionDialog(BuildContext context) {
  return showShadDialog<AccountSuspensionEntity>(
    context: context,
    builder: (context) => const AccountSuspensionDialogContent(),
  );
}
