import 'package:flutter/foundation.dart';
import 'package:growth_pilot_ai/core/models/distilled_context.dart';

/// The sector-scoped payload [BuildIntelligenceBundle] returns (Issue
/// #104) — [context] and [highlights] are strictly derived from the one
/// product this bundle was built for (AC: "Privacy Integrity: No
/// cross-sector data leakage").
@immutable
class IntelligenceBundle {
  final String sector;
  final List<String> radarAxisLabels;
  final DistilledContext context;
  final List<String> highlights;

  const IntelligenceBundle({
    required this.sector,
    required this.radarAxisLabels,
    required this.context,
    required this.highlights,
  });
}
