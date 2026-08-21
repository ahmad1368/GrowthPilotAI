import 'package:growth_pilot_ai/core/data/entities/local_usage_event_entity.dart';

/// "A bar chart comparing the frequency of use for each major module"
/// (Issue #194) — every distinct event label, most-used first.
class SummarizeFeaturePopularity {
  static List<({String label, int count})> call(List<LocalUsageEventEntity> events) {
    final counts = <String, int>{};
    for (final event in events) {
      counts[event.label] = (counts[event.label] ?? 0) + 1;
    }
    final entries = counts.entries.map((e) => (label: e.key, count: e.value)).toList()
      ..sort((a, b) => b.count.compareTo(a.count));
    return entries;
  }
}
