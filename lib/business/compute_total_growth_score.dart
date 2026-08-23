import 'package:growth_pilot_ai/core/data/entities/pulse_event_entity.dart';

/// Sums a reporter's accumulated OmniPulse GrowthScore (Issue #267/#268:
/// "raising their ecosystem GrowthScore") across their past reports — the
/// gratification banner only shows one submission's score, this is the
/// running total that makes it an actual score rather than a one-off toast.
class ComputeTotalGrowthScore {
  static int call(List<PulseEventEntity> events, String reporterId) => events
      .where((e) => e.reporterId == reporterId)
      .fold(0, (total, e) => total + e.growthScoreEarned);
}
