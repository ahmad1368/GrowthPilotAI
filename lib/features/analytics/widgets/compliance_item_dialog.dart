import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/compliance_item_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/compliance_item_dialog_content.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Quick-add form for a compliance/license item (Issue #392). Returns the
/// new item (not yet persisted) or null if cancelled/invalid.
Future<ComplianceItemEntity?> showComplianceItemDialog(BuildContext context) {
  return showShadDialog<ComplianceItemEntity>(
    context: context,
    builder: (context) => const ComplianceItemDialogContent(),
  );
}
