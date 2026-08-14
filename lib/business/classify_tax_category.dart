import 'package:growth_pilot_ai/core/data/entities/banking_gateway_transaction_entity.dart';
import 'package:growth_pilot_ai/core/enum/banking_gateway_provider.dart';
import 'package:growth_pilot_ai/core/enum/tax_category.dart';

/// Rule-based CRA tax-category classification for a settled gateway
/// transaction (Issue #428, acceptance criterion 2) — crypto rails
/// are treated as capital property, cross-currency fiat rails as
/// foreign-exchange gain/loss, and same-currency fiat as ordinary
/// business income; this app has no real accounting integration to
/// derive a more precise category from.
class ClassifyTaxCategory {
  static const domesticCurrency = 'CAD';

  static TaxCategory call(BankingGatewayTransactionEntity transaction) {
    if (transaction.provider.isCrypto) return TaxCategory.capitalGain;
    if (transaction.currency != domesticCurrency) return TaxCategory.foreignExchangeGainLoss;
    return TaxCategory.businessIncome;
  }
}
