import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_seasonal_overhead_narrative.dart';
import 'package:growth_pilot_ai/core/models/seasonal_overhead_point.dart';

void main() {
  test('names the peak month when there is history', () {
    final points = [
      for (var m = 1; m <= 12; m++)
        SeasonalOverheadPoint(month: m, averageExpense: m == 7 ? 900 : 100, isPeak: m == 7),
    ];

    expect(BuildSeasonalOverheadNarrative.call(points), contains('Jul'));
  });

  test('reports insufficient history when every month is 0', () {
    final points = [
      for (var m = 1; m <= 12; m++) SeasonalOverheadPoint(month: m, averageExpense: 0),
    ];

    expect(BuildSeasonalOverheadNarrative.call(points),
        'Not enough expense history yet to spot a seasonal overhead pattern.');
  });
}
