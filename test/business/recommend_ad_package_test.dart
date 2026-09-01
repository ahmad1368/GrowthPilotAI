import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/apply_ad_request_decision.dart';
import 'package:growth_pilot_ai/business/build_ad_request_narrative.dart';
import 'package:growth_pilot_ai/business/recommend_ad_package.dart';
import 'package:growth_pilot_ai/core/data/entities/advertising_request_entity.dart';
import 'package:growth_pilot_ai/core/enum/ad_package_type.dart';
import 'package:growth_pilot_ai/core/enum/ad_request_status.dart';

AdvertisingRequestEntity _request({
  String merchantName = 'Acme Foods',
  String category = 'Grocery',
  AdPackageType packageType = AdPackageType.homepageBanner,
}) =>
    AdvertisingRequestEntity(
      merchantName: merchantName,
      category: category,
      dbPackageType: packageType.index,
      requestedAt: DateTime(2024, 3, 1),
    );

void main() {
  group('RecommendAdPackage', () {
    test('recommends the homepage banner for a high-traffic category', () {
      expect(RecommendAdPackage.call('Grocery'), AdPackageType.homepageBanner);
    });

    test('recommends the featured slot for other categories', () {
      expect(RecommendAdPackage.call('Bicycle Repair'), AdPackageType.featuredSlot);
    });

    test('matches category case-insensitively', () {
      expect(RecommendAdPackage.call('GROCERY'), AdPackageType.homepageBanner);
    });
  });

  group('ApplyAdRequestDecision', () {
    test('marks an approved request accordingly', () {
      final decided = ApplyAdRequestDecision.call(_request(), true);

      expect(decided.status, AdRequestStatus.approved);
    });

    test('marks a denied request accordingly', () {
      final decided = ApplyAdRequestDecision.call(_request(), false);

      expect(decided.status, AdRequestStatus.denied);
    });
  });

  group('BuildAdRequestNarrative', () {
    test('falls back when no requests are submitted', () {
      expect(BuildAdRequestNarrative.call(const []), contains('No advertising requests'));
    });

    test('counts pending requests', () {
      expect(BuildAdRequestNarrative.call([_request()]), contains('1 of 1'));
    });

    test('reports when all requests have been reviewed', () {
      final decided = ApplyAdRequestDecision.call(_request(), true);

      expect(BuildAdRequestNarrative.call([decided]), contains('have been reviewed'));
    });
  });
}
