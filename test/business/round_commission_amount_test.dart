import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/round_commission_amount.dart';

void main() {
  test('rounds to the nearest cent', () {
    expect(RoundCommissionAmount.call(1.005), 1.01);
    expect(RoundCommissionAmount.call(1.004), 1.0);
  });

  test('leaves already-precise amounts unchanged', () {
    expect(RoundCommissionAmount.call(2.5), 2.5);
  });
}
