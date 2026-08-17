import 'package:growth_pilot_ai/core/data/entities/local_usage_event_entity.dart';
import 'package:growth_pilot_ai/core/enum/usage_event_type.dart';

/// Counts logged events by type for the "Transparency Report" (Issue
/// #215's AC: users can see how their data helps improve the app).
class SummarizeUsageEvents {
  static Map<UsageEventType, int> call(List<LocalUsageEventEntity> events) {
    final counts = <UsageEventType, int>{for (final t in UsageEventType.values) t: 0};
    for (final event in events) {
      counts[event.type] = (counts[event.type] ?? 0) + 1;
    }
    return counts;
  }
}
