import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_staff_efficiency_narrative.dart';
import 'package:growth_pilot_ai/business/compute_staff_efficiency.dart';
import 'package:growth_pilot_ai/core/data/entities/staff_shift_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';

TransactionEntity _txn(String description, double amount, DateTime date) =>
    TransactionEntity(
        amount: amount, description: description, date: date, dbType: 1);

void main() {
  group('ComputeStaffEfficiency', () {
    test('returns empty list when no shifts logged', () {
      expect(
          ComputeStaffEfficiency.call(
              [], [_txn('A', 10, DateTime(2024, 3, 1))]),
          isEmpty);
    });

    test('attributes only in-window transactions to a shift', () {
      final shift = StaffShiftEntity(
        staffName: 'Ali',
        startTime: DateTime(2024, 3, 1, 9, 0),
        endTime: DateTime(2024, 3, 1, 11, 0),
      );
      final transactions = [
        _txn('In window', 100, DateTime(2024, 3, 1, 10, 0)),
        _txn('Before shift', 50, DateTime(2024, 3, 1, 8, 0)),
        _txn('After shift', 50, DateTime(2024, 3, 1, 12, 0)),
      ];

      final result = ComputeStaffEfficiency.call([shift], transactions).single;

      expect(result.transactionCount, 1);
      expect(result.totalVolume, 100);
      expect(result.avgTicketSize, 100);
      expect(result.transactionsPerHour, closeTo(0.5, 1e-9));
    });

    test('reports zero metrics for a shift with no handled transactions', () {
      final shift = StaffShiftEntity(
        staffName: 'Sara',
        startTime: DateTime(2024, 3, 1, 9, 0),
        endTime: DateTime(2024, 3, 1, 10, 0),
      );

      final result = ComputeStaffEfficiency.call(
              [shift], [_txn('Other day', 20, DateTime(2024, 3, 2))])
          .single;

      expect(result.transactionCount, 0);
      expect(result.avgTicketSize, 0);
      expect(result.transactionsPerHour, 0);
    });

    test('sorts shifts by transactions-per-hour descending', () {
      final fast = StaffShiftEntity(
        staffName: 'Fast',
        startTime: DateTime(2024, 3, 1, 9, 0),
        endTime: DateTime(2024, 3, 1, 10, 0),
      );
      final slow = StaffShiftEntity(
        staffName: 'Slow',
        startTime: DateTime(2024, 3, 1, 9, 0),
        endTime: DateTime(2024, 3, 1, 13, 0),
      );
      final transactions = [
        _txn('A', 10, DateTime(2024, 3, 1, 9, 30)),
        _txn('B', 10, DateTime(2024, 3, 1, 9, 45)),
      ];

      final results =
          ComputeStaffEfficiency.call([slow, fast], transactions);
      expect(results.first.staffName, 'Fast');
      expect(results.last.staffName, 'Slow');
    });
  });

  group('BuildStaffEfficiencyNarrative', () {
    test('falls back when no shifts are logged', () {
      expect(BuildStaffEfficiencyNarrative.call(const []),
          contains('No staff shifts logged'));
    });

    test('describes the single logged shift', () {
      final shift = StaffShiftEntity(
        staffName: 'Solo',
        startTime: DateTime(2024, 1, 1, 9, 0),
        endTime: DateTime(2024, 1, 1, 10, 0),
      );
      final transactions = [_txn('A', 10, DateTime(2024, 1, 1, 9, 30))];

      final results = ComputeStaffEfficiency.call([shift], transactions);
      expect(BuildStaffEfficiencyNarrative.call(results), contains('Solo'));
    });

    test('names the fastest and slowest performer when multiple exist', () {
      final fast = StaffShiftEntity(
        staffName: 'Fast',
        startTime: DateTime(2024, 3, 1, 9, 0),
        endTime: DateTime(2024, 3, 1, 10, 0),
      );
      final slow = StaffShiftEntity(
        staffName: 'Slow',
        startTime: DateTime(2024, 3, 1, 9, 0),
        endTime: DateTime(2024, 3, 1, 13, 0),
      );
      final transactions = [
        _txn('A', 10, DateTime(2024, 3, 1, 9, 30)),
        _txn('B', 10, DateTime(2024, 3, 1, 9, 45)),
      ];

      final results = ComputeStaffEfficiency.call([slow, fast], transactions);
      final narrative = BuildStaffEfficiencyNarrative.call(results);
      expect(narrative, contains('Fast'));
      expect(narrative, contains('Slow'));
    });
  });
}
