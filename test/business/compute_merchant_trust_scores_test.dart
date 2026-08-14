import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_trust_score_narrative.dart';
import 'package:growth_pilot_ai/business/compute_merchant_trust_scores.dart';
import 'package:growth_pilot_ai/core/data/entities/account_suspension_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/merchant_config_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/service_restriction_entity.dart';
import 'package:growth_pilot_ai/core/enum/merchant_trust_tier.dart';

MerchantConfigEntity _config({
  String businessName = 'Acme Foods',
  String businessId = 'ACM-001',
  double commissionRatePercent = 5,
}) =>
    MerchantConfigEntity(
      businessName: businessName,
      businessId: businessId,
      commissionRatePercent: commissionRatePercent,
      transactionCapAmount: 10000,
      updatedAt: DateTime(2024, 3, 1),
    );

void main() {
  group('ComputeMerchantTrustScores', () {
    test('a merchant with no violations or activity scores 100 and gold tier', () {
      final result = ComputeMerchantTrustScores.call(
          [_config()], const [], const [], const []).single;

      expect(result.score, 100);
      expect(result.tier, MerchantTrustTier.gold);
      expect(result.violationCount, 0);
    });

    test('each active violation lowers the score', () {
      final suspensions = [
        AccountSuspensionEntity(
            merchantName: 'Acme Foods',
            reason: 'Overdue invoice',
            suspendedAt: DateTime(2024, 1, 1),
            expiresAt: DateTime(2024, 1, 2),
            isManuallyLifted: false),
      ];
      final result = ComputeMerchantTrustScores.call(
          [_config()], suspensions, const [], const []).single;

      expect(result.score, 85);
      expect(result.violationCount, 1);
    });

    test('a manually lifted suspension does not count as a violation', () {
      final suspensions = [
        AccountSuspensionEntity(
            merchantName: 'Acme Foods',
            reason: 'False alarm',
            suspendedAt: DateTime(2024, 1, 1),
            expiresAt: DateTime(2024, 1, 2),
            isManuallyLifted: true),
      ];
      final result = ComputeMerchantTrustScores.call(
          [_config()], suspensions, const [], const []).single;

      expect(result.violationCount, 0);
      expect(result.score, 100);
    });

    test('a blocked service restriction counts as a violation', () {
      final restrictions = [
        ServiceRestrictionEntity(
            merchantName: 'Acme Foods',
            serviceName: 'Marketplace',
            isBlocked: true,
            reasonMessage: 'x',
            updatedAt: DateTime(2024, 1, 1)),
      ];
      final result = ComputeMerchantTrustScores.call(
          [_config()], const [], restrictions, const []).single;

      expect(result.violationCount, 1);
    });

    test('a low score falls into the restricted tier with no discount', () {
      final suspensions = List.generate(
          4,
          (_) => AccountSuspensionEntity(
              merchantName: 'Acme Foods',
              reason: 'x',
              suspendedAt: DateTime(2024, 1, 1),
              expiresAt: DateTime(2024, 1, 2),
              isManuallyLifted: false));
      final result = ComputeMerchantTrustScores.call(
          [_config()], suspensions, const [], const []).single;

      expect(result.tier, MerchantTrustTier.restricted);
      expect(result.discountPercent, 0);
      expect(result.effectiveCommissionRate, result.effectiveCommissionRate);
    });

    test('gold tier automatically applies the commission discount', () {
      final result = ComputeMerchantTrustScores.call(
          [_config(commissionRatePercent: 5)], const [], const [], const []).single;

      expect(result.discountPercent, greaterThan(0));
      expect(result.effectiveCommissionRate, lessThan(5));
    });
  });

  group('BuildTrustScoreNarrative', () {
    test('falls back when there are no merchant profiles', () {
      expect(BuildTrustScoreNarrative.call(const []), contains('No merchant profiles'));
    });

    test('falls back when no merchant has reached gold tier', () {
      final suspensions = List.generate(
          4,
          (_) => AccountSuspensionEntity(
              merchantName: 'Acme Foods',
              reason: 'x',
              suspendedAt: DateTime(2024, 1, 1),
              expiresAt: DateTime(2024, 1, 2),
              isManuallyLifted: false));
      final results = ComputeMerchantTrustScores.call([_config()], suspensions, const [], const []);

      expect(BuildTrustScoreNarrative.call(results), contains('No merchants have reached'));
    });

    test('counts gold-tier merchants', () {
      final results = ComputeMerchantTrustScores.call([_config()], const [], const [], const []);

      expect(BuildTrustScoreNarrative.call(results), contains('1 of 1'));
    });
  });
}
