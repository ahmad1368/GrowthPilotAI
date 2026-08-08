import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/find_or_create_exchange_rate_cache.dart';
import 'package:growth_pilot_ai/core/data/entities/exchange_rate_cache_entity.dart';

void main() {
  final now = DateTime(2026, 1, 1);

  test('creates a new cache row when none exists for the pair', () {
    final entry = FindOrCreateExchangeRateCache.call(null, 'CAD:USD', 1.37, now);
    expect(entry.pairKey, 'CAD:USD');
    expect(entry.rate, 1.37);
  });

  test('updates the existing row in place instead of creating a new one', () {
    final existing =
        ExchangeRateCacheEntity(pairKey: 'CAD:USD', rate: 1.30, fetchedAt: now)..id = 5;
    final entry = FindOrCreateExchangeRateCache.call(
        existing, 'CAD:USD', 1.40, now.add(const Duration(hours: 1)));

    expect(identical(entry, existing), isTrue);
    expect(entry.rate, 1.40);
  });
}
