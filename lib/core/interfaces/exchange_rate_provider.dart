import 'package:growth_pilot_ai/core/enum/currency.dart';
import 'package:growth_pilot_ai/core/models/omni_response.dart';

/// "Exchange Rate Synchronization" contract (Issue #153) — a real
/// implementation would poll Fixer.io/Stripe Rates hourly; this app has
/// no such API key, so [MockExchangeRateProvider] returns fixed
/// mid-market rates instead.
abstract class ExchangeRateProvider {
  OmniResult<double> getRate(Currency from, Currency to);
}
