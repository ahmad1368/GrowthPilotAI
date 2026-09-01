import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/core/data/entities/competitor_sighting_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/competitor_proximity_body.dart';

/// Registers the New Competitor Proximity Radar System (Issue #374) as a
/// pluggable report widget under id `COMPETITOR_PROXIMITY_RADAR` (#111).
class CompetitorProximityReportWidget extends BaseReportWidget {
  const CompetitorProximityReportWidget(
      {super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    return CompetitorProximityBody(
      initialSightings: data['sightings'] as List<CompetitorSightingEntity>,
    );
  }
}
