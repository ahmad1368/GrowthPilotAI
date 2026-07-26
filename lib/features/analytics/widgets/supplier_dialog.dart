import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/vendor_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/supplier_dialog_content.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Quick-add form for a supplier (Issue #442). Returns the new vendor (not
/// yet persisted) or null if cancelled/invalid.
Future<VendorEntity?> showSupplierDialog(BuildContext context) {
  return showShadDialog<VendorEntity>(
    context: context,
    builder: (context) => const SupplierDialogContent(),
  );
}
