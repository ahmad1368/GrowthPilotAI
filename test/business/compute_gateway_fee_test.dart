import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_gateway_fee.dart';
import 'package:growth_pilot_ai/core/enum/banking_gateway_provider.dart';

void main() {
  test('stripe charges 2.9% + \$0.30', () {
    expect(ComputeGatewayFee.call(BankingGatewayProvider.stripe, 100), closeTo(3.20, 0.001));
  });

  test('paypal charges 3.49% + \$0.49', () {
    expect(ComputeGatewayFee.call(BankingGatewayProvider.paypal, 100), closeTo(3.98, 0.001));
  });

  test('swift charges a flat \$25 regardless of amount', () {
    expect(ComputeGatewayFee.call(BankingGatewayProvider.swift, 10000), 25.0);
  });

  test('sepa charges a flat \$1 regardless of amount', () {
    expect(ComputeGatewayFee.call(BankingGatewayProvider.sepa, 10000), 1.0);
  });

  test('interac charges a flat \$0.75 regardless of amount (Issue #422)', () {
    expect(ComputeGatewayFee.call(BankingGatewayProvider.interac, 10000), 0.75);
  });

  test('unionPay charges 1.2% (Issue #422)', () {
    expect(ComputeGatewayFee.call(BankingGatewayProvider.unionPay, 100), closeTo(1.20, 0.001));
  });

  test('localNetwork charges 1.5% (Issue #422)', () {
    expect(ComputeGatewayFee.call(BankingGatewayProvider.localNetwork, 100), closeTo(1.50, 0.001));
  });
}
