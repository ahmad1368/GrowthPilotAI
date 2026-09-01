import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_traffic_distribution.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/enum/traffic_view.dart';

TransactionEntity _txAt(DateTime date) =>
    TransactionEntity(amount: 10, date: date, description: 'x');

void main() {
  test('byHour always returns 24 buckets, one per hour', () {
    final points = ComputeTrafficDistribution.call([], TrafficView.byHour);
    expect(points, hasLength(24));
    expect(points.map((p) => p.bucket), List.generate(24, (i) => i));
  });

  test('byDayOfWeek always returns 7 buckets, Monday-first', () {
    final points =
        ComputeTrafficDistribution.call([], TrafficView.byDayOfWeek);
    expect(points, hasLength(7));
  });

  test('counts transactions into their hour bucket', () {
    final points = ComputeTrafficDistribution.call([
      _txAt(DateTime(2026, 3, 5, 14, 10)),
      _txAt(DateTime(2026, 3, 6, 14, 45)),
      _txAt(DateTime(2026, 3, 6, 9, 0)),
    ], TrafficView.byHour);

    expect(points.firstWhere((p) => p.bucket == 14).count, 2);
    expect(points.firstWhere((p) => p.bucket == 9).count, 1);
  });

  test('flags exactly one peak bucket when there is any traffic', () {
    final points = ComputeTrafficDistribution.call([
      _txAt(DateTime(2026, 3, 5, 14, 0)), // Thursday
      _txAt(DateTime(2026, 3, 5, 14, 0)),
      _txAt(DateTime(2026, 3, 6, 9, 0)), // Friday
    ], TrafficView.byHour);

    expect(points.where((p) => p.isPeak), hasLength(1));
    expect(points.firstWhere((p) => p.isPeak).bucket, 14);
  });

  test('no transactions at all leaves every bucket unflagged', () {
    final points = ComputeTrafficDistribution.call([], TrafficView.byHour);
    expect(points.any((p) => p.isPeak), isFalse);
  });
}
