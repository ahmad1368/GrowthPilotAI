import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/route_gateway_fallback.dart';
import 'package:growth_pilot_ai/core/enum/banking_gateway_provider.dart';

void main() {
  test('a failed regional provider falls back to Stripe', () {
    expect(RouteGatewayFallback.call(BankingGatewayProvider.interac), BankingGatewayProvider.stripe);
    expect(RouteGatewayFallback.call(BankingGatewayProvider.unionPay), BankingGatewayProvider.stripe);
  });

  test('a failed Stripe transaction falls back to PayPal, never back to itself', () {
    expect(RouteGatewayFallback.call(BankingGatewayProvider.stripe), BankingGatewayProvider.paypal);
  });
}
