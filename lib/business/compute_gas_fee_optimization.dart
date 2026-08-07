import 'package:growth_pilot_ai/core/enum/banking_gateway_provider.dart';

/// Gas-fee optimization for crypto/stablecoin rails (Issue #423,
/// acceptance criterion 4) — this app has no live network-congestion
/// feed, so "optimization" is a static, documented saving from
/// routing stablecoins over a cheap network (e.g. a Layer-2 or
/// Tron/Polygon-style rail) instead of a standard base-layer gas fee,
/// not a real-time gas auction.
class ComputeGasFeeOptimization {
  static const _standardFee = 2.0;

  static ({double standardFee, double optimizedFee, double savings}) call(
      BankingGatewayProvider provider) {
    final optimized = switch (provider) {
      BankingGatewayProvider.usdt || BankingGatewayProvider.usdc => 0.50,
      BankingGatewayProvider.bitcoin || BankingGatewayProvider.ethereum => 1.50,
      _ => _standardFee,
    };
    return (standardFee: _standardFee, optimizedFee: optimized, savings: _standardFee - optimized);
  }
}
