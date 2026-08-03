import 'package:growth_pilot_ai/core/models/analytics_pricing_upgrade_alert.dart';

/// One-sentence read naming the most recent tariff upgrade requiring
/// admin notification (Issue #336).
class BuildAnalyticsPricingNarrative {
  static String call(List<AnalyticsPricingUpgradeAlert> results) {
    if (results.isEmpty) {
      return 'No pricing tiers logged yet — assign one to start tracking upgrades.';
    }
    final upgrades = results.where((r) => r.isUpgrade);
    if (upgrades.isEmpty) {
      return 'No tariff upgrades yet — ${results.length} merchant tier(s) logged at their initial rate.';
    }
    final latestUpgrade = upgrades.first;
    return '${latestUpgrade.merchantName} upgraded from '
        '${latestUpgrade.previousTierName} to ${latestUpgrade.tierName} '
        '(+${latestUpgrade.feeIncreasePercent.toStringAsFixed(1)}% fee) — notify admin.';
  }
}
