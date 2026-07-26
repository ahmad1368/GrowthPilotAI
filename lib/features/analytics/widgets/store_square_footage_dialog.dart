import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/store_square_footage_dialog_content.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Quick-edit dialog for the store's floor space (Issue #398). Returns the
/// new square footage, or null if cancelled/invalid.
Future<double?> showStoreSquareFootageDialog(BuildContext context, double initial) {
  return showShadDialog<double>(
    context: context,
    builder: (context) => StoreSquareFootageDialogContent(initialSquareFootage: initial),
  );
}
