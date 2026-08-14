import 'package:growth_pilot_ai/core/enum/currency.dart';
import 'package:growth_pilot_ai/core/interfaces/exchange_rate_provider.dart';
import 'package:growth_pilot_ai/core/models/omni_response.dart';

/// Local stand-in for Fixer.io/Stripe Rates (Issue #153) — fixed
/// approximate mid-market rates, since no live rate API key exists.
class MockExchangeRateProvider implements ExchangeRateProvider {
  static const _cadPer = {Currency.cad: 1.0, Currency.usd: 1.37, Currency.eur: 1.47};

  @override
  OmniResult<double> getRate(Currency from, Currency to) async {
    final rate = _cadPer[from]! / _cadPer[to]!;
    return OmniResponse.success(double.parse(rate.toStringAsFixed(6)));
  }
}
