import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/waste_log_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/waste_entry_dialog_content.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Quick-add form for logging a waste entry (Issue #377). Returns the new
/// entry (not yet persisted) or null if cancelled/invalid.
Future<WasteLogEntity?> showWasteEntryDialog(BuildContext context) {
  return showShadDialog<WasteLogEntity>(
    context: context,
    builder: (context) => const WasteEntryDialogContent(),
  );
}
