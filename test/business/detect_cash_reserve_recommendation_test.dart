import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/detect_cash_reserve_recommendation.dart';
import 'package:growth_pilot_ai/core/enum/recommendation_type.dart';

void main() {
  test('flags a balance covering more than 3 months of expenses', () {
    final rec = DetectCashReserveRecommendation.call(
      balance: 50000,
      avgMonthlyExpenses: 10000,
    );

    expect(rec, isNotNull);
    expect(rec!.type, RecommendationType.cashReserve);
    expect(rec.body, contains('20000.00'));
  });

  test('does not flag a balance at exactly the 3-month threshold', () {
    final rec = DetectCashReserveRecommendation.call(
      balance: 30000,
      avgMonthlyExpenses: 10000,
    );

    expect(rec, isNull);
  });

  test('does not flag when average monthly expenses is zero', () {
    final rec = DetectCashReserveRecommendation.call(
      balance: 50000,
      avgMonthlyExpenses: 0,
    );

    expect(rec, isNull);
  });
}
