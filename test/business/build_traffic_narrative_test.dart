import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_traffic_narrative.dart';
import 'package:growth_pilot_ai/core/enum/traffic_view.dart';
import 'package:growth_pilot_ai/core/models/traffic_point.dart';

void main() {
  test('names the peak hour when there is traffic history', () {
    final points = [
      for (var h = 0; h < 24; h++)
        TrafficPoint(bucket: h, count: h == 14 ? 10 : 1, isPeak: h == 14),
    ];

    final narrative = BuildTrafficNarrative.call(points, TrafficView.byHour);

    expect(narrative, contains('2PM'));
    expect(narrative, contains('hour'));
  });

  test('names the peak day when grouped by day of week', () {
    final points = [
      for (var d = 0; d < 7; d++)
        TrafficPoint(bucket: d, count: d == 5 ? 10 : 1, isPeak: d == 5),
    ];

    final narrative =
        BuildTrafficNarrative.call(points, TrafficView.byDayOfWeek);

    expect(narrative, contains('Sat'));
    expect(narrative, contains('day'));
  });

  test('reports insufficient history when every bucket is empty', () {
    final points = [
      for (var h = 0; h < 24; h++) TrafficPoint(bucket: h, count: 0),
    ];

    final narrative = BuildTrafficNarrative.call(points, TrafficView.byHour);

    expect(narrative, contains('Not enough transaction history'));
  });
}
