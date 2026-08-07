import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_gas_fee_optimization.dart';
import 'package:growth_pilot_ai/core/enum/banking_gateway_provider.dart';

void main() {
  test('stablecoins get the cheapest optimized rate', () {
    final result = ComputeGasFeeOptimization.call(BankingGatewayProvider.usdt);
    expect(result.optimizedFee, 0.50);
    expect(result.savings, closeTo(1.50, 0.001));
  });

  test('volatile crypto gets a mid-tier optimized rate', () {
    final result = ComputeGasFeeOptimization.call(BankingGatewayProvider.bitcoin);
    expect(result.optimizedFee, 1.50);
    expect(result.savings, closeTo(0.50, 0.001));
  });

  test('non-crypto providers see no optimization applied', () {
    final result = ComputeGasFeeOptimization.call(BankingGatewayProvider.stripe);
    expect(result.optimizedFee, result.standardFee);
    expect(result.savings, 0);
  });
}
