import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_discount_campaign_impact_narrative.dart';
import 'package:growth_pilot_ai/business/compute_discount_campaign_impact.dart';
import 'package:growth_pilot_ai/core/data/entities/discount_campaign_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';

TransactionEntity _income(String description, double amount, DateTime date) =>
    TransactionEntity(
        amount: amount, description: description, date: date, dbType: 1);

void main() {
  group('ComputeDiscountCampaignImpact', () {
    test('returns empty list when no campaigns or no income logged', () {
      final campaign = DiscountCampaignEntity(
        name: 'Spring Sale',
        discountPercent: 10,
        startDate: DateTime(2024, 3, 1),
        endDate: DateTime(2024, 3, 5),
      );

      expect(ComputeDiscountCampaignImpact.call([], [_income('A', 100, DateTime(2024, 3, 1))]),
          isEmpty);
      expect(ComputeDiscountCampaignImpact.call([campaign], []), isEmpty);
    });

    test('flags profitable campaign when net lift exceeds baseline', () {
      final campaign = DiscountCampaignEntity(
        name: 'Spring Sale',
        discountPercent: 10,
        startDate: DateTime(2024, 3, 5),
        endDate: DateTime(2024, 3, 6),
      );

      final transactions = [
        // Baseline: 4 days outside the campaign window totaling 40 -> daily avg 10.
        _income('A', 10, DateTime(2024, 3, 1)),
        _income('B', 10, DateTime(2024, 3, 2)),
        _income('C', 10, DateTime(2024, 3, 3)),
        _income('D', 10, DateTime(2024, 3, 4)),
        // Campaign window (2 days): 200 revenue.
        _income('E', 100, DateTime(2024, 3, 5)),
        _income('F', 100, DateTime(2024, 3, 6)),
      ];

      final result = ComputeDiscountCampaignImpact.call([campaign], transactions).single;

      expect(result.baselineRevenue, closeTo(20, 1e-9)); // dailyAvg(~6.67) * 2 days
      expect(result.campaignRevenue, 200);
      expect(result.discountCost, closeTo(20, 1e-9));
      expect(result.isProfitable, isTrue);
    });

    test('flags unprofitable campaign when discount cost erases the lift', () {
      final campaign = DiscountCampaignEntity(
        name: 'Deep Discount',
        discountPercent: 90,
        startDate: DateTime(2024, 3, 5),
        endDate: DateTime(2024, 3, 5),
      );

      final transactions = [
        _income('A', 100, DateTime(2024, 3, 1)),
        _income('B', 100, DateTime(2024, 3, 5)),
      ];

      final result = ComputeDiscountCampaignImpact.call([campaign], transactions).single;

      expect(result.isProfitable, isFalse);
    });

    test('sorts campaigns by net profit impact descending', () {
      final good = DiscountCampaignEntity(
        name: 'Good',
        discountPercent: 5,
        startDate: DateTime(2024, 1, 5),
        endDate: DateTime(2024, 1, 5),
      );
      final bad = DiscountCampaignEntity(
        name: 'Bad',
        discountPercent: 80,
        startDate: DateTime(2024, 1, 6),
        endDate: DateTime(2024, 1, 6),
      );

      final transactions = [
        _income('A', 50, DateTime(2024, 1, 1)),
        _income('B', 200, DateTime(2024, 1, 5)),
        _income('C', 60, DateTime(2024, 1, 6)),
      ];

      final results = ComputeDiscountCampaignImpact.call([bad, good], transactions);
      expect(results.first.name, 'Good');
      expect(results.last.name, 'Bad');
    });
  });

  group('BuildDiscountCampaignImpactNarrative', () {
    test('falls back when no campaigns are logged', () {
      expect(BuildDiscountCampaignImpactNarrative.call(const []),
          contains('No discount campaigns logged'));
    });

    test('describes the single logged campaign profitability', () {
      final campaign = DiscountCampaignEntity(
        name: 'Solo Promo',
        discountPercent: 10,
        startDate: DateTime(2024, 1, 1),
        endDate: DateTime(2024, 1, 1),
      );
      final transactions = [_income('A', 100, DateTime(2024, 1, 1))];

      final results = ComputeDiscountCampaignImpact.call([campaign], transactions);
      final narrative = BuildDiscountCampaignImpactNarrative.call(results);
      expect(narrative, contains('Solo Promo'));
    });

    test('names the best and worst performer when multiple exist', () {
      final good = DiscountCampaignEntity(
        name: 'Good',
        discountPercent: 5,
        startDate: DateTime(2024, 1, 5),
        endDate: DateTime(2024, 1, 5),
      );
      final bad = DiscountCampaignEntity(
        name: 'Bad',
        discountPercent: 80,
        startDate: DateTime(2024, 1, 6),
        endDate: DateTime(2024, 1, 6),
      );
      final transactions = [
        _income('A', 50, DateTime(2024, 1, 1)),
        _income('B', 200, DateTime(2024, 1, 5)),
        _income('C', 60, DateTime(2024, 1, 6)),
      ];

      final results = ComputeDiscountCampaignImpact.call([bad, good], transactions);
      final narrative = BuildDiscountCampaignImpactNarrative.call(results);
      expect(narrative, contains('Good'));
      expect(narrative, contains('Bad'));
    });
  });
}
