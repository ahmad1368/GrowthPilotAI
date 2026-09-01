import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/convert_currency.dart';
import 'package:growth_pilot_ai/controllers/exchange_rate_handler.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/exchange_rate_cache_repository.dart';
import 'package:growth_pilot_ai/core/di/dependency_injection.dart';
import 'package:growth_pilot_ai/core/enum/currency.dart';
import 'package:growth_pilot_ai/core/interfaces/exchange_rate_provider.dart';

/// "Currency Switcher" (Issue #153) backend: converts a listing's
/// native price into the buyer's selected [Currency]. The frosted-glass
/// selector widget itself is out of scope per this repo's flat/no-
/// Glassmorphism UI rule — a plain shadcn_ui dropdown is a follow-up.
class CurrencyController extends GetxController {
  final selectedCurrency = Currency.cad.obs;
  late ExchangeRateHandler _rates;

  @override
  void onInit() {
    super.onInit();
    _rates = ExchangeRateHandler(
      DependencyInjection.get<ExchangeRateProvider>(),
      ExchangeRateCacheRepository(Get.find<ObjectBox>().store.box()),
    );
  }

  void selectCurrency(Currency currency) => selectedCurrency.value = currency;

  Future<double?> estimateLocalPrice(double nativeAmount, Currency nativeCurrency) async {
    final rate = await _rates.rateFor(nativeCurrency, selectedCurrency.value);
    if (rate == null) return null;
    return ConvertCurrency.call(nativeAmount, rate);
  }
}
