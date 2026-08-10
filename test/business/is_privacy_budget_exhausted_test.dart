import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/is_privacy_budget_exhausted.dart';

void main() {
  test('is not exhausted below the max budget', () {
    expect(IsPrivacyBudgetExhausted.call(5, 10), isFalse);
  });

  test('is exhausted exactly at the max budget', () {
    expect(IsPrivacyBudgetExhausted.call(10, 10), isTrue);
  });

  test('is exhausted above the max budget', () {
    expect(IsPrivacyBudgetExhausted.call(15, 10), isTrue);
  });
}
