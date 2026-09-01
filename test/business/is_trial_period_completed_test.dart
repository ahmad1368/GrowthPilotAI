import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/is_trial_period_completed.dart';

void main() {
  final now = DateTime(2026, 6, 1);

  test('completed once 180 days have elapsed', () {
    final trialStart = now.subtract(const Duration(days: 180));
    expect(IsTrialPeriodCompleted.call(trialStart, now), true);
  });

  test('not completed before 180 days have elapsed', () {
    final trialStart = now.subtract(const Duration(days: 179));
    expect(IsTrialPeriodCompleted.call(trialStart, now), false);
  });
}
