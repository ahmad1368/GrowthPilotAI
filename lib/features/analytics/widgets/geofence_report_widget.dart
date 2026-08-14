import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/core/data/entities/geofence_zone_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/geofence_body.dart';

/// Registers the Geofencing Access Control tool (Issue #346) as a
/// pluggable report widget under id `GEOFENCING_ACCESS_CONTROL` (#111).
class GeofenceReportWidget extends BaseReportWidget {
  const GeofenceReportWidget({super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    return GeofenceBody(initialZones: data['zones'] as List<GeofenceZoneEntity>);
  }
}
