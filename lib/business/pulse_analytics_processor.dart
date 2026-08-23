import 'package:growth_pilot_ai/core/enum/pulse_category.dart';
import 'package:growth_pilot_ai/core/models/pulse_gratification_result.dart';

/// Computes OmniPulse's "instant gratification" feedback (Issue
/// #267/#268 AC: "Your alert helped 47 financial managers protect an
/// estimated $12,000 in transactions") — a deterministic estimate
/// derived from the report's category and self-reported impact, not a
/// real cross-user measurement (no backend exists in this repo to
/// aggregate real reach; see PR notes).
class PulseAnalyticsProcessor {
  static const _reachPerThousandCad = {
    PulseCategory.financialBlocker: 6,
    PulseCategory.operationalHazard: 4,
    PulseCategory.regulatoryUpdate: 3,
  };

  static PulseGratificationResult call({
    required PulseCategory category,
    required double estimatedImpactCad,
    required int helpfulCount,
  }) {
    final reach = _reachPerThousandCad[category]!;
    final peopleHelped = ((estimatedImpactCad / 1000).ceil() * reach) + helpfulCount;
    final valueProtected = estimatedImpactCad * (1 + helpfulCount * 0.1);

    return PulseGratificationResult(
      estimatedPeopleHelped: peopleHelped,
      estimatedValueProtectedCad: double.parse(valueProtected.toStringAsFixed(2)),
      growthScoreEarned: _scoreFor(estimatedImpactCad, helpfulCount),
    );
  }

  static int _scoreFor(double impact, int helpfulCount) {
    if (impact >= 10000) return 50 + helpfulCount;
    if (impact >= 1000) return 20 + helpfulCount;
    return 5 + helpfulCount;
  }
}
