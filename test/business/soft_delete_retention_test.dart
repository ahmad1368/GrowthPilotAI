import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/retention_policy.dart';
import 'package:growth_pilot_ai/business/soft_delete_filter.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';

TransactionEntity _tx(int id, {required bool deleted}) => TransactionEntity(
      id: id,
      amount: 10,
      date: DateTime(2027, 1, 1),
      description: 'x',
      isDeleted: deleted,
    );

void main() {
  group('SoftDeleteFilter', () {
    final items = [_tx(1, deleted: false), _tx(2, deleted: true), _tx(3, deleted: false)];

    test('active excludes soft-deleted records', () {
      final active = SoftDeleteFilter.active(items, (t) => t.isDeleted);
      expect(active.map((t) => t.id), [1, 3]);
    });

    test('trashed returns only soft-deleted records', () {
      final trashed = SoftDeleteFilter.trashed(items, (t) => t.isDeleted);
      expect(trashed.map((t) => t.id), [2]);
    });
  });

  group('RetentionPolicy', () {
    final now = DateTime(2027, 2, 1);

    test('isPurgeable only past the 30-day window', () {
      expect(RetentionPolicy.isPurgeable(null, now), isFalse);
      expect(RetentionPolicy.isPurgeable(now.subtract(const Duration(days: 10)), now), isFalse);
      expect(RetentionPolicy.isPurgeable(now.subtract(const Duration(days: 31)), now), isTrue);
    });

    test('remaining counts down and floors at zero', () {
      expect(RetentionPolicy.remaining(null, now), isNull);
      final left = RetentionPolicy.remaining(
          now.subtract(const Duration(days: 10)), now);
      expect(left, const Duration(days: 20));
      expect(
        RetentionPolicy.remaining(now.subtract(const Duration(days: 40)), now),
        Duration.zero,
      );
    });
  });
}
