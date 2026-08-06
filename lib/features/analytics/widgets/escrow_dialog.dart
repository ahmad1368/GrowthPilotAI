import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/escrow_account_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/escrow_dialog_content.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// New escrow account wizard (Issue #415, acceptance criterion 1).
/// Returns the new account (not yet persisted) or null if
/// cancelled/invalid.
Future<EscrowAccountEntity?> showEscrowDialog(BuildContext context) {
  return showShadDialog<EscrowAccountEntity>(
    context: context,
    builder: (context) => const EscrowDialogContent(),
  );
}
