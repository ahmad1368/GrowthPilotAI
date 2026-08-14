import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_analytics_pricing_narrative.dart';
import 'package:growth_pilot_ai/business/compute_analytics_pricing_upgrades.dart';
import 'package:growth_pilot_ai/core/data/entities/analytics_pricing_tier_entity.dart';

AnalyticsPricingTierEntity _tier({
  String merchantName = 'Acme Foods',
  String tierName = 'Enterprise',
  required double monthlyFee,
  String previousTierName = '',
  double previousMonthlyFee = 0,
  double invoicedAmount = 0,
  DateTime? effectiveAt,
}) =>
    AnalyticsPricingTierEntity(
      merchantName: merchantName,
      tierName: tierName,
      monthlyFee: monthlyFee,
      previousTierName: previousTierName,
      previousMonthlyFee: previousMonthlyFee,
      invoicedAmount: invoicedAmount,
      effectiveAt: effectiveAt ?? DateTime(2024, 3, 1),
    );

void main() {
  group('ComputeAnalyticsPricingUpgrades', () {
    test('returns empty list when no tiers are logged', () {
      expect(ComputeAnalyticsPricingUpgrades.call(const []), isEmpty);
    });

    test('marks a record with a differing previous tier as an upgrade', () {
      final result = ComputeAnalyticsPricingUpgrades.call([
        _tier(
            tierName: 'Enterprise',
            monthlyFee: 500,
            previousTierName: 'Basic',
            previousMonthlyFee: 200)
      ]).single;

      expect(result.isUpgrade, isTrue);
      expect(result.feeIncreasePercent, closeTo(150.0, 1e-9));
    });

    test('does not mark the initial tier assignment as an upgrade', () {
      final result =
          ComputeAnalyticsPricingUpgrades.call([_tier(monthlyFee: 200)])
              .single;

      expect(result.isUpgrade, isFalse);
      expect(result.feeIncreasePercent, 0);
    });

    test('sorts records by most recent effective date first', () {
      final results = ComputeAnalyticsPricingUpgrades.call([
        _tier(merchantName: 'Old', monthlyFee: 100, effectiveAt: DateTime(2024, 1, 1)),
        _tier(merchantName: 'New', monthlyFee: 100, effectiveAt: DateTime(2024, 6, 1)),
      ]);

      expect(results.first.merchantName, 'New');
      expect(results.last.merchantName, 'Old');
    });
  });

  group('BuildAnalyticsPricingNarrative', () {
    test('falls back when no tiers are logged', () {
      expect(BuildAnalyticsPricingNarrative.call(const []),
          contains('No pricing tiers logged'));
    });

    test('falls back when tiers exist but none are upgrades', () {
      final results =
          ComputeAnalyticsPricingUpgrades.call([_tier(monthlyFee: 200)]);

      expect(BuildAnalyticsPricingNarrative.call(results),
          contains('No tariff upgrades yet'));
    });

    test('names the merchant and tier change for the latest upgrade', () {
      final results = ComputeAnalyticsPricingUpgrades.call([
        _tier(
            merchantName: 'Acme Foods',
            tierName: 'Enterprise',
            monthlyFee: 500,
            previousTierName: 'Basic',
            previousMonthlyFee: 200),
      ]);

      final narrative = BuildAnalyticsPricingNarrative.call(results);
      expect(narrative, contains('Acme Foods'));
      expect(narrative, contains('Basic'));
      expect(narrative, contains('Enterprise'));
    });
  });
}
