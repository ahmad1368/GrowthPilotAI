import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_promo_engagement_rate.dart';
import 'package:growth_pilot_ai/business/record_promo_click.dart';
import 'package:growth_pilot_ai/business/record_promo_impression.dart';
import 'package:growth_pilot_ai/business/select_promo_card_for_context.dart';
import 'package:growth_pilot_ai/core/data/entities/advertising_request_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/promo_card_metrics_entity.dart';
import 'package:growth_pilot_ai/core/enum/ad_package_type.dart';
import 'package:growth_pilot_ai/core/enum/ad_request_status.dart';
import 'package:growth_pilot_ai/core/enum/business_sector.dart';

AdvertisingRequestEntity _request({
  String merchantName = 'Acme Foods',
  String category = 'retail',
  AdRequestStatus status = AdRequestStatus.approved,
  DateTime? requestedAt,
}) {
  final request = AdvertisingRequestEntity(
    merchantName: merchantName,
    category: category,
    dbPackageType: AdPackageType.homepageBanner.index,
    requestedAt: requestedAt ?? DateTime(2024, 3, 1),
  );
  request.status = status;
  return request;
}

void main() {
  group('SelectPromoCardForContext', () {
    test('returns null when there are no approved requests', () {
      expect(SelectPromoCardForContext.call(const [], BusinessSector.retail), isNull);
    });

    test('ignores pending/denied requests', () {
      final requests = [_request(status: AdRequestStatus.pending)];

      expect(SelectPromoCardForContext.call(requests, BusinessSector.retail), isNull);
    });

    test('prefers a request whose category matches the current sector', () {
      final requests = [
        _request(merchantName: 'Other', category: 'tech'),
        _request(merchantName: 'Match', category: 'retail'),
      ];

      final result = SelectPromoCardForContext.call(requests, BusinessSector.retail);
      expect(result!.merchantName, 'Match');
    });

    test('falls back to the most recently approved request when no category matches', () {
      final requests = [
        _request(merchantName: 'Old', category: 'tech', requestedAt: DateTime(2024, 1, 1)),
        _request(merchantName: 'New', category: 'tech', requestedAt: DateTime(2024, 6, 1)),
      ];

      final result = SelectPromoCardForContext.call(requests, BusinessSector.construction);
      expect(result!.merchantName, 'New');
    });
  });

  group('RecordPromoImpression', () {
    test('starts a new counter when none exists', () {
      final result = RecordPromoImpression.call(null, 1, DateTime(2024, 3, 1));

      expect(result.impressionCount, 1);
      expect(result.advertisingRequestId, 1);
    });

    test('increments an existing counter', () {
      final existing = PromoCardMetricsEntity(
          advertisingRequestId: 1, impressionCount: 4, lastImpressionAt: DateTime(2024, 1, 1));
      final result = RecordPromoImpression.call(existing, 1, DateTime(2024, 3, 1));

      expect(result.impressionCount, 5);
    });
  });

  group('RecordPromoClick', () {
    test('increments the click counter without affecting impressions', () {
      final existing = PromoCardMetricsEntity(
          advertisingRequestId: 1,
          impressionCount: 10,
          clickCount: 2,
          lastImpressionAt: DateTime(2024, 1, 1));
      final result = RecordPromoClick.call(existing);

      expect(result.clickCount, 3);
      expect(result.impressionCount, 10);
    });
  });

  group('ComputePromoEngagementRate', () {
    test('returns zero when there are no impressions yet', () {
      expect(ComputePromoEngagementRate.call(null), 0);
    });

    test('computes the click-through rate', () {
      final metrics = PromoCardMetricsEntity(
          advertisingRequestId: 1,
          impressionCount: 20,
          clickCount: 5,
          lastImpressionAt: DateTime(2024, 1, 1));

      expect(ComputePromoEngagementRate.call(metrics), closeTo(25.0, 1e-9));
    });
  });
}
