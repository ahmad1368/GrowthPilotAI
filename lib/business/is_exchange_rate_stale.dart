/// Pairs with [ExchangeRateCacheEntity] — true once a cached rate is
/// older than the AC-mandated 60-minute freshness window.
class IsExchangeRateStale {
  static const freshness = Duration(minutes: 60);

  static bool call(DateTime fetchedAt, DateTime now) => now.difference(fetchedAt) > freshness;
}
