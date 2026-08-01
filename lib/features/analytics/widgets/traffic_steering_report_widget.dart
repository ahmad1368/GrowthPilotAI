import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/core/data/entities/traffic_steering_directive_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/traffic_steering_body.dart';

/// Registers the Targeted Merchant Traffic Steering Engine (Issue #334)
/// as a pluggable report widget under id `TRAFFIC_STEERING_ENGINE`
/// (#111).
class TrafficSteeringReportWidget extends BaseReportWidget {
  const TrafficSteeringReportWidget(
      {super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    return TrafficSteeringBody(
      initialDirectives:
          data['directives'] as List<TrafficSteeringDirectiveEntity>,
    );
  }
}
