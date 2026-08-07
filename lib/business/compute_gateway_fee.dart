import 'package:growth_pilot_ai/business/compute_gas_fee_optimization.dart';
import 'package:growth_pilot_ai/core/enum/banking_gateway_provider.dart';

/// Transparent per-provider transaction fee (Issue #421, acceptance
/// criterion 2; regional rates added for Issue #422; crypto gas fees
/// added for Issue #423) — these mirror each provider's typical
/// public rate card, not a live-negotiated merchant rate, since
/// there's no real account behind any of them.
class ComputeGatewayFee {
  static double call(BankingGatewayProvider provider, double convertedAmount) {
    if (provider.isCrypto) return ComputeGasFeeOptimization.call(provider).optimizedFee;
    return switch (provider) {
      BankingGatewayProvider.stripe => convertedAmount * 0.029 + 0.30,
      BankingGatewayProvider.paypal => convertedAmount * 0.0349 + 0.49,
      BankingGatewayProvider.swift => 25.0,
      BankingGatewayProvider.sepa => 1.0,
      BankingGatewayProvider.interac => 0.75,
      BankingGatewayProvider.unionPay => convertedAmount * 0.012,
      BankingGatewayProvider.localNetwork => convertedAmount * 0.015,
      _ => 0, // unreachable: crypto providers handled above
    };
  }
}
