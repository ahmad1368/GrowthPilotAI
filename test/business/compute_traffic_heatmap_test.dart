import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_heatmap_optimization_narrative.dart';
import 'package:growth_pilot_ai/business/compute_traffic_heatmap.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/enum/traffic_day_part.dart';

void main() {
  group('ComputeTrafficHeatmap', () {
    test('buckets transactions by day-of-week and day-part', () {
      final transactions = [
        TransactionEntity(
            amount: 10,
            description: 'a',
            date: DateTime(2024, 1, 1, 8)), // Mon morning
        TransactionEntity(
            amount: 10,
            description: 'b',
            date: DateTime(2024, 1, 1, 9)), // Mon morning
        TransactionEntity(
            amount: 10,
            description: 'c',
            date: DateTime(2024, 1, 2, 22)), // Tue night
      ];

      final cells = ComputeTrafficHeatmap.call(transactions);

      expect(cells.length, 28);
      final monMorning = cells.firstWhere(
          (c) => c.dayOfWeek == 0 && c.dayPart == TrafficDayPart.morning);
      final tueNight = cells.firstWhere(
          (c) => c.dayOfWeek == 1 && c.dayPart == TrafficDayPart.night);

      expect(monMorning.count, 2);
      expect(monMorning.intensity, 1.0);
      expect(monMorning.isPeak, isTrue);
      expect(tueNight.count, 1);
      expect(tueNight.intensity, 0.5);
      expect(tueNight.isPeak, isFalse);
    });

    test('returns all-zero cells for no transactions', () {
      final cells = ComputeTrafficHeatmap.call(const []);
      expect(cells.length, 28);
      expect(cells.every((c) => c.count == 0 && c.intensity == 0), isTrue);
    });
  });

  group('BuildHeatmapOptimizationNarrative', () {
    test('falls back when there is no traffic history', () {
      final cells = ComputeTrafficHeatmap.call(const []);
      expect(BuildHeatmapOptimizationNarrative.call(cells),
          contains('Not enough transaction history'));
    });

    test('names the hottest and coldest windows', () {
      final transactions = [
        TransactionEntity(
            amount: 10,
            description: 'a',
            date: DateTime(2024, 1, 6, 14)), // Sat afternoon
        TransactionEntity(
            amount: 10,
            description: 'b',
            date: DateTime(2024, 1, 6, 15)), // Sat afternoon
        TransactionEntity(
            amount: 10,
            description: 'c',
            date: DateTime(2024, 1, 2, 7)), // Tue morning
      ];

      final cells = ComputeTrafficHeatmap.call(transactions);
      final narrative = BuildHeatmapOptimizationNarrative.call(cells);

      expect(narrative, contains('Sat afternoon'));
      expect(narrative, contains('Tue morning'));
    });
  });
}
