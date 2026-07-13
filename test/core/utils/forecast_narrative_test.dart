import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/utils/forecast_narrative.dart';

void main() {
  group('ForecastNarrative.hasEnoughData', () {
    test('is false with fewer than 3 active days', () {
      expect(ForecastNarrative.hasEnoughData([10.0, 0.0, 5.0]), isFalse);
    });

    test('is true with 3 or more active days', () {
      expect(ForecastNarrative.hasEnoughData([10.0, 20.0, 5.0, 0.0]), isTrue);
    });
  });

  group('ForecastNarrative.windowTotal', () {
    test('sums the window and rounds to 2 decimals', () {
      expect(ForecastNarrative.windowTotal([100.0, 50.5, 49.5]), 200.0);
    });

    test('returns 0 for an empty window', () {
      expect(ForecastNarrative.windowTotal([]), 0.0);
    });
  });

  group('ForecastNarrative.comparisonPct', () {
    test('is positive when the forecast average exceeds history', () {
      final pct =
          ForecastNarrative.comparisonPct([30.0, 30.0], [10.0, 20.0]);
      expect(pct, greaterThan(0));
    });

    test('is negative when the forecast average is below history', () {
      final pct =
          ForecastNarrative.comparisonPct([5.0, 5.0], [10.0, 20.0]);
      expect(pct, lessThan(0));
    });
  });

  group('ForecastNarrative labels', () {
    test('formats the weekly total label in CAD', () {
      expect(
        ForecastNarrative.windowTotalLabel([1000.0, 1200.0, 1000.0], 7),
        r'Projected total for next 7 days: $3,200.00',
      );
    });

    test('formats a single-day label in CAD', () {
      expect(
        ForecastNarrative.singleDayLabel(540.0, 'Saturday'),
        r'Likely spending for Saturday: $540.00',
      );
    });
  });
}
