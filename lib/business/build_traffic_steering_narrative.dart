import 'package:growth_pilot_ai/core/models/traffic_steering_summary.dart';

/// One-sentence read naming the most-redirected steering target (Issue
/// #334).
class BuildTrafficSteeringNarrative {
  static String call(List<TrafficSteeringSummary> results) {
    if (results.isEmpty) {
      return 'No steering directives logged yet — add one to start monitoring traffic deviation.';
    }
    final top = results.first;
    return '${top.targetName} has been steered toward "${top.destinationLabel}" '
        '${top.redirectCount} times (${top.deviationSharePercent.toStringAsFixed(1)}% of all redirects).';
  }
}
