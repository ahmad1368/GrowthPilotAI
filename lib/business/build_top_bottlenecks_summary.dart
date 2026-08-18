import 'package:growth_pilot_ai/core/models/bottleneck_insight.dart';

/// "Top 3 Bottlenecks" for the native Health Check panel (Issue #223,
/// section 3) — sorted most-severe first.
class BuildTopBottlenecksSummary {
  static const maxResults = 3;

  static List<BottleneckInsight> call(List<BottleneckInsight> insights) {
    final sorted = [...insights]
      ..sort((a, b) => b.severity.index.compareTo(a.severity.index));
    return sorted.take(maxResults).toList();
  }
}
