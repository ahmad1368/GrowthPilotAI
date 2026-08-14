import 'package:growth_pilot_ai/core/models/revenue_dependency_snapshot.dart';

/// One-sentence, rule-based diversification prompt (Issue #376).
class BuildRevenueDependencyNarrative {
  static String call(RevenueDependencySnapshot snapshot) {
    if (snapshot.totalRevenue <= 0) {
      return 'Not enough income history yet to evaluate revenue dependency.';
    }
    if (snapshot.isConcentrationRisk) {
      final pct = (snapshot.topCustomerShare * 100).toStringAsFixed(0);
      return '${snapshot.topCustomerLabel} accounts for $pct% of revenue — '
          'diversify acquisition channels to reduce single-account risk.';
    }
    final pct = (snapshot.repeatRevenueShare * 100).toStringAsFixed(0);
    return '$pct% of revenue comes from repeat buyers — no single account '
        'dominates your revenue base.';
  }
}
