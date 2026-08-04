import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_search_results.dart';
import 'package:growth_pilot_ai/business/compute_search_relevance.dart';
import 'package:growth_pilot_ai/business/search_organic_results.dart';
import 'package:growth_pilot_ai/business/search_sponsored_results.dart';
import 'package:growth_pilot_ai/core/data/entities/advertising_request_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/merchant_config_entity.dart';
import 'package:growth_pilot_ai/core/enum/ad_request_status.dart';

AdvertisingRequestEntity _ad({
  String merchantName = 'Acme Bicycle Repair',
  String category = 'Bicycle Repair',
  AdRequestStatus status = AdRequestStatus.approved,
  DateTime? requestedAt,
}) {
  final request = AdvertisingRequestEntity(
    merchantName: merchantName,
    category: category,
    dbPackageType: 0,
    requestedAt: requestedAt ?? DateTime(2024, 3, 1),
  );
  request.status = status;
  return request;
}

MerchantConfigEntity _config({String businessName = 'Downtown Laundromat'}) =>
    MerchantConfigEntity(
      businessName: businessName,
      businessId: 'B-1',
      commissionRatePercent: 5,
      transactionCapAmount: 1000,
      updatedAt: DateTime(2024, 3, 1),
    );

void main() {
  group('ComputeSearchRelevance', () {
    test('scores a prefix match highest', () {
      expect(ComputeSearchRelevance.call('Bicycle Repair', 'bicycle'), 1.0);
    });

    test('scores a substring match lower than a prefix match', () {
      expect(ComputeSearchRelevance.call('Downtown Bicycle Repair', 'bicycle'), 0.6);
    });

    test('scores zero for no match', () {
      expect(ComputeSearchRelevance.call('Laundromat', 'bicycle'), 0);
    });

    test('scores zero for a blank query', () {
      expect(ComputeSearchRelevance.call('Bicycle Repair', ''), 0);
    });
  });

  group('SearchSponsoredResults', () {
    test('excludes requests that are not approved', () {
      final results =
          SearchSponsoredResults.call([_ad(status: AdRequestStatus.pending)], 'bicycle');

      expect(results, isEmpty);
    });

    test('excludes requests with no keyword relevance', () {
      expect(SearchSponsoredResults.call([_ad()], 'laundromat'), isEmpty);
    });

    test('matches on category or merchant name', () {
      final results = SearchSponsoredResults.call([_ad()], 'bicycle');

      expect(results, hasLength(1));
      expect(results.single.isSponsored, isTrue);
    });

    test('breaks ties between equally relevant results by recency', () {
      final results = SearchSponsoredResults.call([
        _ad(merchantName: 'Old Bicycle Shop', requestedAt: DateTime(2024, 1, 1)),
        _ad(merchantName: 'New Bicycle Shop', requestedAt: DateTime(2024, 6, 1)),
      ], 'bicycle');

      expect(results.first.name, 'New Bicycle Shop');
    });
  });

  group('SearchOrganicResults', () {
    test('matches by business name', () {
      final results = SearchOrganicResults.call([_config()], 'laundromat');

      expect(results, hasLength(1));
      expect(results.single.isSponsored, isFalse);
    });
  });

  group('BuildSearchResults', () {
    test('places sponsored results before organic results', () {
      final sponsored = SearchSponsoredResults.call([_ad()], 'bicycle');
      final organic = SearchOrganicResults.call(
          [_config(businessName: 'Bicycle World')], 'bicycle');

      final combined = BuildSearchResults.call(sponsored, organic);
      expect(combined.first.isSponsored, isTrue);
    });
  });
}
