import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_account_suspension_narrative.dart';
import 'package:growth_pilot_ai/business/compute_account_suspension_statuses.dart';
import 'package:growth_pilot_ai/business/is_account_suspended.dart';
import 'package:growth_pilot_ai/core/data/entities/account_suspension_entity.dart';

final _now = DateTime(2024, 3, 10);

AccountSuspensionEntity _suspension({
  String merchantName = 'Acme Foods',
  String reason = 'Overdue invoice',
  DateTime? suspendedAt,
  DateTime? expiresAt,
  bool isManuallyLifted = false,
}) =>
    AccountSuspensionEntity(
      merchantName: merchantName,
      reason: reason,
      suspendedAt: suspendedAt ?? _now.subtract(const Duration(hours: 1)),
      expiresAt: expiresAt ?? _now.add(const Duration(hours: 23)),
      isManuallyLifted: isManuallyLifted,
    );

void main() {
  group('ComputeAccountSuspensionStatuses', () {
    test('returns empty list when no suspensions are logged', () {
      expect(ComputeAccountSuspensionStatuses.call(const [], _now), isEmpty);
    });

    test('is active while now is before the expiry timeframe', () {
      final result =
          ComputeAccountSuspensionStatuses.call([_suspension()], _now).single;

      expect(result.isActive, isTrue);
    });

    test('automatically unsuspends once now passes expiresAt', () {
      final result = ComputeAccountSuspensionStatuses.call([
        _suspension(
            suspendedAt: _now.subtract(const Duration(days: 2)),
            expiresAt: _now.subtract(const Duration(hours: 1))),
      ], _now).single;

      expect(result.isActive, isFalse);
    });

    test('an unexpired but manually lifted suspension is not active', () {
      final result = ComputeAccountSuspensionStatuses.call(
          [_suspension(isManuallyLifted: true)], _now).single;

      expect(result.isActive, isFalse);
    });

    test('keeps only the most recently suspended record per merchant', () {
      final results = ComputeAccountSuspensionStatuses.call([
        _suspension(reason: 'Old', suspendedAt: _now.subtract(const Duration(days: 5))),
        _suspension(reason: 'New', suspendedAt: _now.subtract(const Duration(hours: 1))),
      ], _now);

      expect(results, hasLength(1));
      expect(results.single.reason, 'New');
    });
  });

  group('IsAccountSuspended', () {
    test('returns false when the merchant has no logged suspension', () {
      expect(IsAccountSuspended.call(const [], 'Acme Foods'), isFalse);
    });

    test('returns true for an actively suspended merchant', () {
      final statuses = ComputeAccountSuspensionStatuses.call([_suspension()], _now);

      expect(IsAccountSuspended.call(statuses, 'Acme Foods'), isTrue);
    });
  });

  group('BuildAccountSuspensionNarrative', () {
    test('falls back when no suspensions are logged', () {
      expect(BuildAccountSuspensionNarrative.call(const []),
          contains('No suspensions logged'));
    });

    test('falls back when no merchants are currently suspended', () {
      final statuses = ComputeAccountSuspensionStatuses.call(
          [_suspension(isManuallyLifted: true)], _now);

      expect(BuildAccountSuspensionNarrative.call(statuses),
          contains('No merchants are currently suspended'));
    });

    test('names the most recently suspended active merchant', () {
      final statuses = ComputeAccountSuspensionStatuses.call([_suspension()], _now);

      final narrative = BuildAccountSuspensionNarrative.call(statuses);
      expect(narrative, contains('Acme Foods'));
      expect(narrative, contains('Overdue invoice'));
    });
  });
}
