import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/activate_campaign_from_payment.dart';
import 'package:growth_pilot_ai/core/data/entities/ad_campaign_constraint_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/advertising_request_entity.dart';
import 'package:growth_pilot_ai/core/enum/ad_package_type.dart';
import 'package:growth_pilot_ai/core/enum/ad_request_status.dart';

AdvertisingRequestEntity _pendingRequest(AdPackageType type) => AdvertisingRequestEntity(
      id: 5,
      merchantName: 'Test Merchant',
      category: 'Retail',
      dbPackageType: type.index,
      requestedAt: DateTime(2026, 1, 1),
    );

void main() {
  final now = DateTime(2026, 1, 1);

  test('a pending request becomes approved on activation', () {
    final result = ActivateCampaignFromPayment.call(
        request: _pendingRequest(AdPackageType.featuredSlot), now: now);

    expect(result.request.status, AdRequestStatus.approved);
    expect(result.request.id, 5);
  });

  test('without a pre-configured constraint, tier defaults are applied', () {
    final result = ActivateCampaignFromPayment.call(
        request: _pendingRequest(AdPackageType.homepageBanner), now: now);

    expect(result.constraint.maxDurationDays, 30);
    expect(result.constraint.maxImpressions, 10000);
    expect(result.constraint.advertisingRequestId, 5);
  });

  test('a pre-configured constraint is reused instead of overwritten', () {
    final existing = AdCampaignConstraintEntity(
      advertisingRequestId: 5,
      maxDurationDays: 3,
      maxImpressions: 50,
      maxClicks: 5,
      createdAt: now,
    );

    final result = ActivateCampaignFromPayment.call(
        request: _pendingRequest(AdPackageType.featuredSlot),
        existingConstraint: existing,
        now: now);

    expect(result.constraint, same(existing));
  });
}
