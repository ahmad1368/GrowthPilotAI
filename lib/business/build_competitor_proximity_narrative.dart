import 'package:growth_pilot_ai/core/models/competitor_proximity_impact.dart';

/// One-sentence read naming the biggest logged nearby competitor threat
/// (Issue #374).
class BuildCompetitorProximityNarrative {
  static String call(List<CompetitorProximityImpact> results) {
    if (results.isEmpty) {
      return 'No new competitors logged yet — add a sighting to start tracking nearby threats.';
    }
    final biggest = results.first;
    if (results.length == 1) {
      return '${biggest.competitorName} (${biggest.category}) opened '
          '${biggest.distanceKm.toStringAsFixed(1)}km away.';
    }
    return '${biggest.competitorName} (${biggest.category}) is your biggest nearby threat at '
        '${biggest.distanceKm.toStringAsFixed(1)}km — ${results.length} competitors logged total.';
  }
}
