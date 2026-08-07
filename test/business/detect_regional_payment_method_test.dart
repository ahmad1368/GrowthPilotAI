import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/detect_regional_payment_method.dart';
import 'package:growth_pilot_ai/core/enum/banking_gateway_provider.dart';

void main() {
  test('CAD routes to Interac', () {
    expect(DetectRegionalPaymentMethod.call('CAD'), BankingGatewayProvider.interac);
  });

  test('CNY routes to UnionPay', () {
    expect(DetectRegionalPaymentMethod.call('cny'), BankingGatewayProvider.unionPay);
  });

  test('major Western currencies route to the generic local network', () {
    expect(DetectRegionalPaymentMethod.call('USD'), BankingGatewayProvider.localNetwork);
    expect(DetectRegionalPaymentMethod.call('EUR'), BankingGatewayProvider.localNetwork);
  });

  test('an unrecognized currency defaults to Stripe', () {
    expect(DetectRegionalPaymentMethod.call('XYZ'), BankingGatewayProvider.stripe);
  });
}
