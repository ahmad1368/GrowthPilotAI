import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/classify_efficiency_gap.dart';
import 'package:growth_pilot_ai/core/enum/efficiency_gap_status.dart';

void main() {
  test('scores above 80 are an Excellent Deal', () {
    expect(ClassifyEfficiencyGap.call(81), EfficiencyGapStatus.excellentDeal);
    expect(ClassifyEfficiencyGap.call(100), EfficiencyGapStatus.excellentDeal);
  });

  test('scores from 51 to 80 are Fair Value', () {
    expect(ClassifyEfficiencyGap.call(51), EfficiencyGapStatus.fairValue);
    expect(ClassifyEfficiencyGap.call(80), EfficiencyGapStatus.fairValue);
  });

  test('scores at or below 50 are Below Average', () {
    expect(ClassifyEfficiencyGap.call(50), EfficiencyGapStatus.belowAverage);
    expect(ClassifyEfficiencyGap.call(0), EfficiencyGapStatus.belowAverage);
  });
}
