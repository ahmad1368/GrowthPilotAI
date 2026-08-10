import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_efficiency_gap_insight.dart';

void main() {
  test('formats a savings tip when both figures are available', () {
    expect(BuildEfficiencyGapInsight.call(15, 5),
        'You could save 15% by driving 5 minutes further.');
  });

  test('uses singular "minute" for exactly one minute', () {
    expect(BuildEfficiencyGapInsight.call(10, 1),
        'You could save 10% by driving 1 minute further.');
  });

  test('returns null when savings percent is missing', () {
    expect(BuildEfficiencyGapInsight.call(null, 5), isNull);
  });

  test('returns null when extra minutes is missing', () {
    expect(BuildEfficiencyGapInsight.call(15, null), isNull);
  });

  test('returns null when there is no savings to report', () {
    expect(BuildEfficiencyGapInsight.call(0, 5), isNull);
  });
}
