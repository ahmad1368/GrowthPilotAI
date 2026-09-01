import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_consumer_behavior_recommendation.dart';
import 'package:growth_pilot_ai/business/compute_consumer_behavior_segments.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/models/consumer_behavior_insight.dart';

TransactionEntity _sale({required double amount, required DateTime date}) =>
    TransactionEntity(
      amount: amount,
      date: date,
      description: 'sale',
      dbType: TransactionType.income.index,
      dbSyncStatus: SyncStatus.synced.index,
      dbPaymentMethod: PaymentMethod.unspecified.index,
    );

void main() {
  group('ComputeConsumerBehaviorSegments', () {
    test('returns zeroed insight when no transactions are logged', () {
      final insight = ComputeConsumerBehaviorSegments.call(const []);
      expect(insight.averageBasketSize, 0);
      expect(insight.visitFrequencyPerWeek, 0);
      expect(insight.budgetFriendlyShare, 0);
      expect(insight.fitTier, LowIncomeFitTier.weak);
    });

    test('computes budget-friendly share from income transactions only', () {
      final insight = ComputeConsumerBehaviorSegments.call([
        _sale(amount: 10, date: DateTime(2024, 3, 1)),
        _sale(amount: 20, date: DateTime(2024, 3, 1)),
        _sale(amount: 100, date: DateTime(2024, 3, 1)),
      ]);

      expect(insight.budgetFriendlyShare, closeTo(66.67, 0.01));
    });

    test('tiers fit as strong/moderate/weak by budget-friendly share', () {
      final strong = ComputeConsumerBehaviorSegments.call(
          [_sale(amount: 10, date: DateTime(2024, 3, 1))]);
      final weak = ComputeConsumerBehaviorSegments.call(
          [_sale(amount: 500, date: DateTime(2024, 3, 1))]);

      expect(strong.fitTier, LowIncomeFitTier.strong);
      expect(weak.fitTier, LowIncomeFitTier.weak);
    });

    test('computes visit frequency per week across the transaction span', () {
      final insight = ComputeConsumerBehaviorSegments.call([
        _sale(amount: 10, date: DateTime(2024, 3, 1)),
        _sale(amount: 10, date: DateTime(2024, 3, 8)),
        _sale(amount: 10, date: DateTime(2024, 3, 15)),
      ]);

      expect(insight.visitFrequencyPerWeek, closeTo(1.0, 0.01));
    });

    test('treats a single-day transaction history as one week span', () {
      final insight = ComputeConsumerBehaviorSegments.call(
          [_sale(amount: 10, date: DateTime(2024, 3, 1))]);

      expect(insight.visitFrequencyPerWeek, closeTo(1.0, 0.01));
    });
  });

  group('BuildConsumerBehaviorRecommendation', () {
    test('recommends value tier for a weak fit', () {
      final insight = ComputeConsumerBehaviorSegments.call(
          [_sale(amount: 500, date: DateTime(2024, 3, 1))]);

      expect(BuildConsumerBehaviorRecommendation.call(insight),
          contains('value tier'));
    });

    test('praises stocking essentials for a strong fit', () {
      final insight = ComputeConsumerBehaviorSegments.call(
          [_sale(amount: 10, date: DateTime(2024, 3, 1))]);

      expect(BuildConsumerBehaviorRecommendation.call(insight),
          contains('essential goods'));
    });
  });
}
