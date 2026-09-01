import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/conflict_resolver.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/enum/conflict_outcome.dart';
import 'package:growth_pilot_ai/core/models/cloud_transaction.dart';

TransactionEntity _local(DateTime modified,
        {double amount = 10, bool deleted = false}) =>
    TransactionEntity(
      amount: amount,
      date: DateTime(2027, 1, 1),
      description: 'x',
      lastModified: modified,
      isDeleted: deleted,
    );

CloudTransaction _cloud(DateTime modified,
        {double amount = 99, bool deleted = false}) =>
    CloudTransaction(
      localId: '1',
      userId: 'user-a',
      amount: amount,
      lastModified: modified,
      isDeleted: deleted,
    );

void main() {
  final t0 = DateTime.utc(2027, 1, 10, 8);
  final t1 = DateTime.utc(2027, 1, 10, 9);

  group('ConflictResolver.resolve', () {
    test('cloud newer -> takeCloud', () {
      expect(ConflictResolver.resolve(_local(t0), _cloud(t1)),
          ConflictOutcome.takeCloud);
    });

    test('local newer -> pushLocal', () {
      expect(ConflictResolver.resolve(_local(t1), _cloud(t0)),
          ConflictOutcome.pushLocal);
    });

    test('equal timestamps -> inSync (idempotent)', () {
      expect(ConflictResolver.resolve(_local(t0), _cloud(t0)),
          ConflictOutcome.inSync);
    });

    test('newer cloud soft-delete -> deleteBoth', () {
      expect(
          ConflictResolver.resolve(_local(t0), _cloud(t1, deleted: true)),
          ConflictOutcome.deleteBoth);
    });

    test('newer local soft-delete -> deleteBoth', () {
      expect(
          ConflictResolver.resolve(_local(t1, deleted: true), _cloud(t0)),
          ConflictOutcome.deleteBoth);
    });

    test('compares in UTC regardless of local-time zone offset', () {
      final localTx = _local(DateTime.utc(2027, 1, 10, 12));
      final cloud = _cloud(DateTime.utc(2027, 1, 10, 12));
      expect(ConflictResolver.resolve(localTx, cloud), ConflictOutcome.inSync);
    });
  });

  group('ConflictResolver.applyCloud', () {
    test('overwrites data + sync metadata but never the identity', () {
      final localTx = _local(t0, amount: 10);
      ConflictResolver.applyCloud(localTx, _cloud(t1, amount: 250));
      expect(localTx.amount, 250);
      expect(localTx.lastModified, t1);
      expect(localTx.syncStatus, SyncStatus.synced);
    });
  });

  group('ConflictResolver performance', () {
    test('resolves 100 records well under budget', () {
      final pairs = List.generate(
          100, (i) => (_local(t0), _cloud(i.isEven ? t1 : t0)));
      final sw = Stopwatch()..start();
      for (final p in pairs) {
        ConflictResolver.resolve(p.$1, p.$2);
      }
      sw.stop();
      expect(sw.elapsedMilliseconds, lessThan(50));
    });
  });
}
