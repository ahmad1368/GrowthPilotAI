import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_foot_traffic_narrative.dart';
import 'package:growth_pilot_ai/business/compute_traffic_analytics.dart';
import 'package:growth_pilot_ai/business/find_peak_traffic_weekday.dart';
import 'package:growth_pilot_ai/core/data/entities/traffic_count_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';

TrafficCountEntity _count({
  required int footTraffic,
  required int vehicleTraffic,
  required DateTime date,
}) =>
    TrafficCountEntity(
        footTraffic: footTraffic, vehicleTraffic: vehicleTraffic, date: date);

TransactionEntity _sale(DateTime date) => TransactionEntity(
      amount: 10,
      date: date,
      description: 'sale',
      dbType: TransactionType.income.index,
      dbSyncStatus: SyncStatus.synced.index,
      dbPaymentMethod: PaymentMethod.unspecified.index,
    );

void main() {
  group('ComputeTrafficAnalytics', () {
    test('returns empty list when no counts are logged', () {
      expect(ComputeTrafficAnalytics.call(const [], const []), isEmpty);
    });

    test('matches same-day transactions and computes conversion percent', () {
      final date = DateTime(2024, 3, 4); // Monday
      final result = ComputeTrafficAnalytics.call(
        [_count(footTraffic: 100, vehicleTraffic: 20, date: date)],
        [_sale(date), _sale(date)],
      ).single;

      expect(result.salesCount, 2);
      expect(result.conversionPercent, closeTo(2.0, 1e-9));
      expect(result.weekdayLabel, 'Monday');
    });

    test('avoids division by zero when foot traffic is zero', () {
      final result = ComputeTrafficAnalytics.call(
        [_count(footTraffic: 0, vehicleTraffic: 5, date: DateTime(2024, 3, 4))],
        const [],
      ).single;

      expect(result.conversionPercent, 0);
    });

    test('sorts results by conversion percent descending', () {
      final good = _count(
          footTraffic: 10, vehicleTraffic: 0, date: DateTime(2024, 3, 4));
      final bad = _count(
          footTraffic: 1000, vehicleTraffic: 0, date: DateTime(2024, 3, 5));

      final results = ComputeTrafficAnalytics.call(
          [bad, good], [_sale(DateTime(2024, 3, 4)), _sale(DateTime(2024, 3, 5))]);
      expect(results.first.date, DateTime(2024, 3, 4));
    });
  });

  group('FindPeakTrafficWeekday', () {
    test('returns null when no results are logged', () {
      expect(FindPeakTrafficWeekday.call(const []), isNull);
    });

    test('picks the weekday with the highest average total traffic', () {
      final results = ComputeTrafficAnalytics.call([
        _count(footTraffic: 500, vehicleTraffic: 100, date: DateTime(2024, 3, 4)),
        _count(footTraffic: 10, vehicleTraffic: 5, date: DateTime(2024, 3, 5)),
      ], const []);

      expect(FindPeakTrafficWeekday.call(results), 'Monday');
    });
  });

  group('BuildFootTrafficNarrative', () {
    test('falls back when no counts are logged', () {
      expect(BuildFootTrafficNarrative.call(const []),
          contains('No traffic counts logged'));
    });

    test('names the peak weekday when multiple days exist', () {
      final results = ComputeTrafficAnalytics.call([
        _count(footTraffic: 500, vehicleTraffic: 100, date: DateTime(2024, 3, 4)),
        _count(footTraffic: 10, vehicleTraffic: 5, date: DateTime(2024, 3, 5)),
      ], const []);

      expect(BuildFootTrafficNarrative.call(results), contains('Monday'));
    });
  });
}
