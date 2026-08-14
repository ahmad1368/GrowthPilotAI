import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_leaderboard.dart';
import 'package:growth_pilot_ai/core/data/entities/advertising_request_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/merchant_config_entity.dart';
import 'package:growth_pilot_ai/core/enum/ad_request_status.dart';

MerchantConfigEntity _config(String name, double cap) => MerchantConfigEntity(
      businessName: name,
      businessId: name,
      commissionRatePercent: 0,
      transactionCapAmount: cap,
      updatedAt: DateTime(2026, 1, 1),
    );

AdvertisingRequestEntity _approved(String name, DateTime requestedAt) =>
    AdvertisingRequestEntity(
      merchantName: name,
      category: 'Retail',
      dbPackageType: 0,
      dbStatus: AdRequestStatus.approved.index,
      requestedAt: requestedAt,
    );

void main() {
  test('sponsored entries are always ranked above organic ones', () {
    final result = BuildLeaderboard.call(
      [_config('HighCap', 10000), _config('LowCap', 100)],
      [_approved('LowCap', DateTime(2026, 1, 1))],
    );

    expect(result.first.name, 'LowCap');
    expect(result.first.isSponsored, true);
    expect(result.first.rank, 1);
    expect(result.last.name, 'HighCap');
    expect(result.last.isSponsored, false);
  });

  test('a sponsored merchant is not duplicated in the organic section', () {
    final result = BuildLeaderboard.call(
      [_config('Sponsor', 500)],
      [_approved('Sponsor', DateTime(2026, 1, 1))],
    );

    expect(result, hasLength(1));
  });

  test('organic entries are ranked by score, highest first', () {
    final result = BuildLeaderboard.call(
      [_config('A', 100), _config('B', 900), _config('C', 500)],
      [],
    );

    expect(result.map((e) => e.name).toList(), ['B', 'C', 'A']);
  });

  test('pending advertising requests are not treated as sponsored', () {
    final pending = AdvertisingRequestEntity(
      merchantName: 'NotYet',
      category: 'Retail',
      dbPackageType: 0,
      requestedAt: DateTime(2026, 1, 1),
    );

    final result = BuildLeaderboard.call([_config('NotYet', 100)], [pending]);

    expect(result.single.isSponsored, false);
  });
}
