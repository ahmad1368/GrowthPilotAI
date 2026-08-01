import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/traffic_count_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/traffic_count_dialog_content.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Quick-add form for logging a daily foot/vehicle traffic count
/// (Issue #381). Returns the new count (not yet persisted) or null if
/// cancelled/invalid.
Future<TrafficCountEntity?> showTrafficCountDialog(BuildContext context) {
  return showShadDialog<TrafficCountEntity>(
    context: context,
    builder: (context) => const TrafficCountDialogContent(),
  );
}
