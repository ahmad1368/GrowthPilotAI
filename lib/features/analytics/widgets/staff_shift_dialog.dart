import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/staff_shift_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/staff_shift_dialog_content.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Quick-add form for logging a staff shift (Issue #379). Returns the
/// new shift (not yet persisted) or null if cancelled/invalid.
Future<StaffShiftEntity?> showStaffShiftDialog(BuildContext context) {
  return showShadDialog<StaffShiftEntity>(
    context: context,
    builder: (context) => const StaffShiftDialogContent(),
  );
}
