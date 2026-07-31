import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/warranty_claim_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/warranty_claim_dialog_content.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Quick-add form for logging a warranty claim (Issue #389). Returns the
/// new claim (not yet persisted) or null if cancelled/invalid.
Future<WarrantyClaimEntity?> showWarrantyClaimDialog(BuildContext context) {
  return showShadDialog<WarrantyClaimEntity>(
    context: context,
    builder: (context) => const WarrantyClaimDialogContent(),
  );
}
