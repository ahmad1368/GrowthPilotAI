import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/verify_sponsored_placement.dart';
import 'package:growth_pilot_ai/core/data/entities/advertising_request_entity.dart';
import 'package:growth_pilot_ai/core/enum/ad_request_status.dart';
import 'package:growth_pilot_ai/core/models/leaderboard_entry.dart';

void main() {
  const entry = LeaderboardEntry(
    rank: 1,
    name: 'Sponsor Co',
    score: double.infinity,
    isSponsored: true,
    sourceRequestId: 7,
  );

  test('an approved matching request is legitimate', () {
    final request = AdvertisingRequestEntity(
      id: 7,
      merchantName: 'Sponsor Co',
      category: 'Retail',
      dbPackageType: 0,
      dbStatus: AdRequestStatus.approved.index,
      requestedAt: DateTime(2026, 1, 1),
    );

    final result = VerifySponsoredPlacement.call(entry, [request]);

    expect(result.legitimate, true);
    expect(result.log.newValue, contains('legitimate'));
    expect(result.log.targetMerchant, 'Sponsor Co');
  });

  test('a denied or missing request is not legitimate', () {
    final denied = AdvertisingRequestEntity(
      id: 7,
      merchantName: 'Sponsor Co',
      category: 'Retail',
      dbPackageType: 0,
      dbStatus: AdRequestStatus.denied.index,
      requestedAt: DateTime(2026, 1, 1),
    );

    final result = VerifySponsoredPlacement.call(entry, [denied]);

    expect(result.legitimate, false);
    expect(result.log.newValue, contains('illegitimate'));
  });

  test('no matching request at all is not legitimate', () {
    final result = VerifySponsoredPlacement.call(entry, []);

    expect(result.legitimate, false);
  });
}
