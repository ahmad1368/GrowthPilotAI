import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/cap_expansion_request_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/cap_expansion_request_dialog_content.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Cap expansion request form (Issue #344). Returns the new request
/// (not yet persisted) or null if cancelled/invalid.
Future<CapExpansionRequestEntity?> showCapExpansionRequestDialog(BuildContext context) {
  return showShadDialog<CapExpansionRequestEntity>(
    context: context,
    builder: (context) => const CapExpansionRequestDialogContent(),
  );
}
