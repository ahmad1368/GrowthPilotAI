import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_welcome_back_summary.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';

void main() {
  group('BuildWelcomeBackSummary', () {
    test('counts only transactions and insights after lastActiveAt', () {
      final lastActiveAt = DateTime(2026, 1, 1);
      final now = DateTime(2026, 1, 15);
      final transactions = [
        TransactionEntity(amount: 10, date: DateTime(2025, 12, 20), description: 'old'),
        TransactionEntity(amount: 20, date: DateTime(2026, 1, 5), description: 'new1'),
        TransactionEntity(amount: 30, date: DateTime(2026, 1, 10), description: 'new2'),
      ];
      final insightsSince = [DateTime(2026, 1, 6)];

      final summary = BuildWelcomeBackSummary.call(
        lastActiveAt: lastActiveAt,
        now: now,
        allTransactions: transactions,
        insightsSentSince: insightsSince,
      );

      expect(summary.daysAway, 14);
      expect(summary.newTransactionsCount, 2);
      expect(summary.newInsightsCount, 1);
      expect(summary.hasAnyUpdates, isTrue);
    });

    test('no new activity reports hasAnyUpdates false', () {
      final summary = BuildWelcomeBackSummary.call(
        lastActiveAt: DateTime(2026, 1, 1),
        now: DateTime(2026, 1, 15),
        allTransactions: const [],
        insightsSentSince: const [],
      );

      expect(summary.hasAnyUpdates, isFalse);
    });
  });
}
