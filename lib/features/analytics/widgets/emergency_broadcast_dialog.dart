import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/emergency_broadcast_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/emergency_broadcast_dialog_content.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Compose form for a new emergency broadcast (Issue #345). Returns the
/// dispatch record (not yet persisted) or null if cancelled/invalid.
Future<EmergencyBroadcastEntity?> showEmergencyBroadcastDialog(BuildContext context) {
  return showShadDialog<EmergencyBroadcastEntity>(
    context: context,
    builder: (context) => const EmergencyBroadcastDialogContent(),
  );
}
