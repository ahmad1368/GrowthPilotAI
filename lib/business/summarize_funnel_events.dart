import 'package:growth_pilot_ai/core/data/entities/local_usage_event_entity.dart';

/// "Visualize the conversion funnel from 'App Install' to 'Account
/// Verified'" (Issue #194) — counts each named funnel step in
/// [stepOrder], in order, so a UI can render a drop-off funnel.
class SummarizeFunnelEvents {
  static List<({String label, int count})> call(List<LocalUsageEventEntity> events, List<String> stepOrder) {
    final counts = <String, int>{for (final step in stepOrder) step: 0};
    for (final event in events) {
      if (counts.containsKey(event.label)) counts[event.label] = counts[event.label]! + 1;
    }
    return [for (final step in stepOrder) (label: step, count: counts[step]!)];
  }
}
