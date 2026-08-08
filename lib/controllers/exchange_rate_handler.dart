import 'package:growth_pilot_ai/business/find_or_create_exchange_rate_cache.dart';
import 'package:growth_pilot_ai/business/is_exchange_rate_stale.dart';
import 'package:growth_pilot_ai/core/data/repositories/exchange_rate_cache_repository.dart';
import 'package:growth_pilot_ai/core/enum/currency.dart';
import 'package:growth_pilot_ai/core/interfaces/exchange_rate_provider.dart';

/// Cache-then-fetch orchestration for #153's hourly rate sync, kept out
/// of [CurrencyController] for SRP.
class ExchangeRateHandler {
  final ExchangeRateProvider provider;
  final ExchangeRateCacheRepository cache;

  ExchangeRateHandler(this.provider, this.cache);

  Future<double?> rateFor(Currency from, Currency to) async {
    if (from == to) return 1.0;
    final pairKey = '${from.code}:${to.code}';
    final cached = cache.getForPair(pairKey);

    if (cached != null && !IsExchangeRateStale.call(cached.fetchedAt, DateTime.now())) {
      return cached.rate;
    }

    final fetched = await provider.getRate(from, to);
    if (!fetched.success || fetched.data == null) return cached?.rate;

    final entry = FindOrCreateExchangeRateCache.call(cached, pairKey, fetched.data!, DateTime.now());
    cache.upsert(entry);
    return entry.rate;
  }
}
