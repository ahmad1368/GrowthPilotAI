import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/geofence_zone_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/geofence_zone_dialog_content.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Add/edit form for a geofence zone (Issue #346). Pass [existing] to
/// pre-fill and edit that zone in place. Returns the zone to persist
/// (not yet saved) or null if cancelled/invalid.
Future<GeofenceZoneEntity?> showGeofenceZoneDialog(BuildContext context,
    {GeofenceZoneEntity? existing}) {
  return showShadDialog<GeofenceZoneEntity>(
    context: context,
    builder: (context) => GeofenceZoneDialogContent(existing: existing),
  );
}
