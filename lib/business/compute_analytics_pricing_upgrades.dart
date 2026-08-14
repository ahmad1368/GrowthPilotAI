import 'package:growth_pilot_ai/core/data/entities/analytics_pricing_tier_entity.dart';
import 'package:growth_pilot_ai/core/models/analytics_pricing_upgrade_alert.dart';

/// Derives each logged pricing tier assignment's upgrade status and fee
/// delta from its previous tier (Issue #336) — this app has no backend
/// billing service, so tier changes and settled invoices are logged
/// manually instead.
class ComputeAnalyticsPricingUpgrades {
  static List<AnalyticsPricingUpgradeAlert> call(
      List<AnalyticsPricingTierEntity> tiers) {
    final results = tiers.map((t) {
      final isUpgrade =
          t.previousTierName.isNotEmpty && t.previousTierName != t.tierName;
      final feeIncreasePercent = t.previousMonthlyFee == 0
          ? 0.0
          : ((t.monthlyFee - t.previousMonthlyFee) / t.previousMonthlyFee) *
              100;

      return AnalyticsPricingUpgradeAlert(
        merchantName: t.merchantName,
        tierName: t.tierName,
        previousTierName: t.previousTierName,
        monthlyFee: t.monthlyFee,
        invoicedAmount: t.invoicedAmount,
        isUpgrade: isUpgrade,
        feeIncreasePercent: double.parse(feeIncreasePercent.toStringAsFixed(2)),
        effectiveAt: t.effectiveAt,
      );
    }).toList();

    results.sort((a, b) => b.effectiveAt.compareTo(a.effectiveAt));
    return results;
  }
}
