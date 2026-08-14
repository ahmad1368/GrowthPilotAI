import 'package:growth_pilot_ai/core/data/entities/exchange_rate_cache_entity.dart';

/// Builds a fresh cache row when none exists yet for a currency pair,
/// mirroring #149's `FindOrCreateInvoiceSyncStatus` pattern.
class FindOrCreateExchangeRateCache {
  static ExchangeRateCacheEntity call(
      ExchangeRateCacheEntity? existing, String pairKey, double rate, DateTime now) {
    if (existing != null) {
      existing.rate = rate;
      existing.fetchedAt = now;
      return existing;
    }
    return ExchangeRateCacheEntity(pairKey: pairKey, rate: rate, fetchedAt: now);
  }
}
