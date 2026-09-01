import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_merchant_partnership_narrative.dart';
import 'package:growth_pilot_ai/business/compute_merchant_partnership_value.dart';
import 'package:growth_pilot_ai/core/data/entities/merchant_partnership_entity.dart';
import 'package:growth_pilot_ai/core/models/merchant_partnership_value.dart';

MerchantPartnershipEntity _partnership({
  String partnerBusinessName = 'Corner Cafe',
  String partnerCategory = 'cafe',
  required double customerOverlapScore,
  required double jointCampaignRevenue,
  required int referralCount,
  DateTime? partneredAt,
}) =>
    MerchantPartnershipEntity(
      partnerBusinessName: partnerBusinessName,
      partnerCategory: partnerCategory,
      customerOverlapScore: customerOverlapScore,
      jointCampaignRevenue: jointCampaignRevenue,
      referralCount: referralCount,
      partneredAt: partneredAt ?? DateTime(2024, 3, 1),
    );

void main() {
  group('ComputeMerchantPartnershipValue', () {
    test('returns empty list when no partnerships are logged', () {
      expect(ComputeMerchantPartnershipValue.call(const []), isEmpty);
    });

    test('computes revenue per referral', () {
      final result = ComputeMerchantPartnershipValue.call([
        _partnership(
            customerOverlapScore: 50,
            jointCampaignRevenue: 1000,
            referralCount: 4)
      ]).single;

      expect(result.revenuePerReferral, closeTo(250, 1e-9));
    });

    test('avoids division by zero when no referrals are logged', () {
      final result = ComputeMerchantPartnershipValue.call([
        _partnership(
            customerOverlapScore: 50, jointCampaignRevenue: 1000, referralCount: 0)
      ]).single;

      expect(result.revenuePerReferral, 0);
    });

    test('tiers synergy level by customer overlap score', () {
      final low = ComputeMerchantPartnershipValue.call([
        _partnership(
            customerOverlapScore: 39, jointCampaignRevenue: 0, referralCount: 0)
      ]).single;
      final medium = ComputeMerchantPartnershipValue.call([
        _partnership(
            customerOverlapScore: 40, jointCampaignRevenue: 0, referralCount: 0)
      ]).single;
      final high = ComputeMerchantPartnershipValue.call([
        _partnership(
            customerOverlapScore: 70, jointCampaignRevenue: 0, referralCount: 0)
      ]).single;

      expect(low.synergyLevel, PartnershipSynergyLevel.low);
      expect(medium.synergyLevel, PartnershipSynergyLevel.medium);
      expect(high.synergyLevel, PartnershipSynergyLevel.high);
      expect(high.isHighValue, isTrue);
      expect(low.isHighValue, isFalse);
    });

    test('sorts partnerships by joint campaign revenue descending', () {
      final good = _partnership(
          partnerBusinessName: 'Good',
          customerOverlapScore: 80,
          jointCampaignRevenue: 5000,
          referralCount: 10);
      final bad = _partnership(
          partnerBusinessName: 'Bad',
          customerOverlapScore: 20,
          jointCampaignRevenue: 100,
          referralCount: 2);

      final results = ComputeMerchantPartnershipValue.call([bad, good]);
      expect(results.first.partnerBusinessName, 'Good');
      expect(results.last.partnerBusinessName, 'Bad');
    });
  });

  group('BuildMerchantPartnershipNarrative', () {
    test('falls back when no partnerships are logged', () {
      expect(BuildMerchantPartnershipNarrative.call(const []),
          contains('No partnerships logged'));
    });

    test('names the top collaborative partner when multiple exist', () {
      final good = _partnership(
          partnerBusinessName: 'Good',
          customerOverlapScore: 80,
          jointCampaignRevenue: 5000,
          referralCount: 10);
      final bad = _partnership(
          partnerBusinessName: 'Bad',
          customerOverlapScore: 20,
          jointCampaignRevenue: 100,
          referralCount: 2);

      final results = ComputeMerchantPartnershipValue.call([bad, good]);
      final narrative = BuildMerchantPartnershipNarrative.call(results);
      expect(narrative, contains('Good'));
    });
  });
}
