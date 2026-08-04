import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/core/data/entities/emergency_broadcast_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/emergency_broadcast_body.dart';

/// Registers the Regional Emergency Broadcast & Messaging Tool (Issue
/// #345) as a pluggable report widget under id
/// `EMERGENCY_BROADCAST_TOOL` (#111).
class EmergencyBroadcastReportWidget extends BaseReportWidget {
  const EmergencyBroadcastReportWidget(
      {super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    return EmergencyBroadcastBody(
      initialBroadcasts: data['broadcasts'] as List<EmergencyBroadcastEntity>,
    );
  }
}
