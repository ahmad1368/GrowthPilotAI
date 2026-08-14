import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/traffic_steering_directive_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/traffic_steering_dialog_content.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Quick-add form for logging a traffic-steering directive (Issue #334).
/// Returns the new directive (not yet persisted) or null if
/// cancelled/invalid.
Future<TrafficSteeringDirectiveEntity?> showTrafficSteeringDialog(
    BuildContext context) {
  return showShadDialog<TrafficSteeringDirectiveEntity>(
    context: context,
    builder: (context) => const TrafficSteeringDialogContent(),
  );
}
