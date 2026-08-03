import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_merchant_config_narrative.dart';
import 'package:growth_pilot_ai/business/search_merchant_configs.dart';
import 'package:growth_pilot_ai/core/data/entities/merchant_config_entity.dart';

MerchantConfigEntity _config({
  String businessName = 'Acme Foods',
  String businessId = 'ACM-001',
  double commissionRatePercent = 5,
  double transactionCapAmount = 10000,
  DateTime? updatedAt,
}) =>
    MerchantConfigEntity(
      businessName: businessName,
      businessId: businessId,
      commissionRatePercent: commissionRatePercent,
      transactionCapAmount: transactionCapAmount,
      updatedAt: updatedAt ?? DateTime(2024, 3, 1),
    );

void main() {
  group('SearchMerchantConfigs', () {
    test('returns every profile, most recently updated first, for a blank query', () {
      final results = SearchMerchantConfigs.call([
        _config(businessName: 'Old', updatedAt: DateTime(2024, 1, 1)),
        _config(businessName: 'New', updatedAt: DateTime(2024, 6, 1)),
      ], '');

      expect(results, hasLength(2));
      expect(results.first.businessName, 'New');
    });

    test('matches on business name, case-insensitively', () {
      final results = SearchMerchantConfigs.call(
          [_config(businessName: 'Acme Foods')], 'acme');

      expect(results, hasLength(1));
    });

    test('matches on business ID', () {
      final results =
          SearchMerchantConfigs.call([_config(businessId: 'ACM-001')], 'acm-001');

      expect(results, hasLength(1));
    });

    test('excludes profiles that match neither field', () {
      final results = SearchMerchantConfigs.call(
          [_config(businessName: 'Acme Foods', businessId: 'ACM-001')],
          'nonexistent');

      expect(results, isEmpty);
    });
  });

  group('BuildMerchantConfigNarrative', () {
    test('falls back when no profiles are configured', () {
      expect(BuildMerchantConfigNarrative.call(const []),
          contains('No merchant profiles configured'));
    });

    test('names the most recently updated profile', () {
      final results = SearchMerchantConfigs.call([
        _config(businessName: 'Acme Foods', businessId: 'ACM-001', commissionRatePercent: 7.5),
      ], '');

      final narrative = BuildMerchantConfigNarrative.call(results);
      expect(narrative, contains('Acme Foods'));
      expect(narrative, contains('ACM-001'));
      expect(narrative, contains('7.5%'));
    });
  });
}
