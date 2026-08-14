import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/apply_cap_expansion_decision.dart';
import 'package:growth_pilot_ai/business/build_cap_expansion_request.dart';
import 'package:growth_pilot_ai/business/build_daily_cap_narrative.dart';
import 'package:growth_pilot_ai/business/check_daily_cap_breach.dart';
import 'package:growth_pilot_ai/business/compute_daily_transaction_total.dart';
import 'package:growth_pilot_ai/business/dispatch_daily_cap_breach_notification.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/enum/cap_expansion_status.dart';

TransactionEntity _txn({required double amount, required DateTime date, bool isDeleted = false}) =>
    TransactionEntity(amount: amount, date: date, description: 'x', isDeleted: isDeleted);

void main() {
  final today = DateTime(2024, 3, 10);

  group('ComputeDailyTransactionTotal', () {
    test('sums only transactions on the given day', () {
      final total = ComputeDailyTransactionTotal.call([
        _txn(amount: 100, date: today),
        _txn(amount: 50, date: today.add(const Duration(days: 1))),
      ], today);

      expect(total, 100);
    });

    test('excludes soft-deleted transactions', () {
      final total = ComputeDailyTransactionTotal.call(
          [_txn(amount: 100, date: today, isDeleted: true)], today);

      expect(total, 0);
    });
  });

  group('CheckDailyCapBreach', () {
    test('is not blocked when total is within the cap', () {
      expect(CheckDailyCapBreach.call(400, 500), isFalse);
    });

    test('is blocked once total exceeds the cap', () {
      expect(CheckDailyCapBreach.call(600, 500), isTrue);
    });
  });

  group('DispatchDailyCapBreachNotification', () {
    test('returns null when not blocked', () {
      final notice = DispatchDailyCapBreachNotification.call(
          isBlocked: false,
          dailyTotal: 400,
          capAmount: 500,
          day: today,
          alreadyDispatchedIds: {});

      expect(notice, isNull);
    });

    test('builds a notification the first time a day breaches', () {
      final notice = DispatchDailyCapBreachNotification.call(
          isBlocked: true,
          dailyTotal: 600,
          capAmount: 500,
          day: today,
          alreadyDispatchedIds: {});

      expect(notice, isNotNull);
      expect(notice!.metadataRefType, 'DailyCap');
    });

    test('does not re-dispatch for a day already notified', () {
      final key = 'DailyCap|${today.year}-${today.month}-${today.day}';
      final notice = DispatchDailyCapBreachNotification.call(
          isBlocked: true,
          dailyTotal: 600,
          capAmount: 500,
          day: today,
          alreadyDispatchedIds: {key});

      expect(notice, isNull);
    });
  });

  group('ApplyCapExpansionDecision', () {
    test('marks an approved request accordingly', () {
      final request = BuildCapExpansionRequest.call(requestedCapAmount: 1000, reason: 'growth');
      final decided = ApplyCapExpansionDecision.call(request, true);

      expect(decided.status, CapExpansionStatus.approved);
    });

    test('marks a denied request accordingly', () {
      final request = BuildCapExpansionRequest.call(requestedCapAmount: 1000, reason: 'growth');
      final decided = ApplyCapExpansionDecision.call(request, false);

      expect(decided.status, CapExpansionStatus.denied);
    });
  });

  group('BuildDailyCapNarrative', () {
    test('reports being within cap with no pending requests', () {
      final narrative = BuildDailyCapNarrative.call(
          dailyTotal: 400, capAmount: 500, isBlocked: false, requests: const []);

      expect(narrative, contains('Within cap'));
    });

    test('reports being blocked and mentions pending requests', () {
      final pending = BuildCapExpansionRequest.call(requestedCapAmount: 1000, reason: 'growth');
      final narrative = BuildDailyCapNarrative.call(
          dailyTotal: 600, capAmount: 500, isBlocked: true, requests: [pending]);

      expect(narrative, contains('Blocked'));
      expect(narrative, contains('1 expansion request'));
    });
  });
}
