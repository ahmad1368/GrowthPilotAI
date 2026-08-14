import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/enforce_campaign_constraint.dart';
import 'package:growth_pilot_ai/core/data/entities/advertising_request_entity.dart';
import 'package:growth_pilot_ai/core/enum/ad_request_status.dart';
import 'package:growth_pilot_ai/core/enum/campaign_constraint_status.dart';

AdvertisingRequestEntity _approvedRequest() => AdvertisingRequestEntity(
      id: 1,
      merchantName: 'Test Merchant',
      category: 'Retail',
      dbPackageType: 0,
      dbStatus: AdRequestStatus.approved.index,
      requestedAt: DateTime(2026, 1, 1),
    );

void main() {
  test('an active campaign is left untouched', () {
    final result = EnforceCampaignConstraint.call(_approvedRequest(), CampaignConstraintStatus.active);

    expect(result, isNull);
  });

  test('an expired approved campaign is auto-denied with an audit entry', () {
    final result =
        EnforceCampaignConstraint.call(_approvedRequest(), CampaignConstraintStatus.expiredByTime);

    expect(result, isNotNull);
    expect(result!.request.status, AdRequestStatus.denied);
    expect(result.request.id, 1);
    expect(result.log.targetMerchant, 'Test Merchant');
    expect(result.log.changeType, contains('expiredByTime'));
  });

  test('a campaign already denied is not re-enforced', () {
    final denied = AdvertisingRequestEntity(
      id: 1,
      merchantName: 'Test Merchant',
      category: 'Retail',
      dbPackageType: 0,
      dbStatus: AdRequestStatus.denied.index,
      requestedAt: DateTime(2026, 1, 1),
    );

    final result = EnforceCampaignConstraint.call(denied, CampaignConstraintStatus.cappedByClicks);

    expect(result, isNull);
  });
}
