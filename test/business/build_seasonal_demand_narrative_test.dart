import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_seasonal_demand_narrative.dart';
import 'package:growth_pilot_ai/core/models/seasonal_demand_point.dart';

void main() {
  test('names the peak month when there is history', () {
    final points = [
      for (var m = 1; m <= 12; m++)
        SeasonalDemandPoint(
            month: m, averageRevenue: m == 7 ? 500 : 100, isPeak: m == 7),
    ];

    final narrative = BuildSeasonalDemandNarrative.call(points);

    expect(narrative, contains('Jul'));
  });

  test('reports insufficient history when every month is 0', () {
    final points = [
      for (var m = 1; m <= 12; m++)
        SeasonalDemandPoint(month: m, averageRevenue: 0),
    ];

    final narrative = BuildSeasonalDemandNarrative.call(points);

    expect(narrative, contains('Not enough transaction history'));
  });
}
