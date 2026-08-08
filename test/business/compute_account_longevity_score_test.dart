import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_account_longevity_score.dart';

void main() {
  final now = DateTime(2026, 1, 1);

  test('a brand new account scores near zero', () {
    expect(ComputeAccountLongevityScore.call(now, now), 0.0);
  });

  test('a one-year-old account scores at the max', () {
    final oneYearAgo = now.subtract(const Duration(days: 365));
    expect(ComputeAccountLongevityScore.call(oneYearAgo, now), 1.0);
  });

  test('clamps beyond the one-year baseline', () {
    final fiveYearsAgo = now.subtract(const Duration(days: 365 * 5));
    expect(ComputeAccountLongevityScore.call(fiveYearsAgo, now), 1.0);
  });

  test('halfway to a year scores about half', () {
    final sixMonthsAgo = now.subtract(const Duration(days: 182));
    expect(ComputeAccountLongevityScore.call(sixMonthsAgo, now), closeTo(0.5, 0.02));
  });
}
