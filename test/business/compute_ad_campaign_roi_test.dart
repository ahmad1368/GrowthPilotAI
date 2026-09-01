import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_ad_campaign_roi_narrative.dart';
import 'package:growth_pilot_ai/business/compute_ad_campaign_roi.dart';
import 'package:growth_pilot_ai/core/data/entities/ad_campaign_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';

TransactionEntity _income(String description, double amount, DateTime date) =>
    TransactionEntity(
        amount: amount, description: description, date: date, dbType: 1);

void main() {
  group('ComputeAdCampaignRoi', () {
    test('computes attributed revenue, acquisitions, and positive ROI', () {
      final campaign = AdCampaignEntity(
        name: 'Spring Promo',
        cost: 100,
        startDate: DateTime(2024, 3, 1),
        endDate: DateTime(2024, 3, 10),
      )..channel = AdChannel.digital;

      final transactions = [
        _income('A', 200, DateTime(2024, 3, 5)),
        _income('B', 50, DateTime(2024, 2, 1)), // outside window
      ];

      final result =
          ComputeAdCampaignRoi.call([campaign], transactions).single;

      expect(result.attributedRevenue, 200);
      expect(result.newCustomersAcquired, 1);
      expect(result.costPerAcquisition, 100);
      expect(result.roi, closeTo(1.0, 1e-9));
      expect(result.isPositiveRoi, isTrue);
    });

    test('flags negative ROI when cost exceeds attributed revenue', () {
      final campaign = AdCampaignEntity(
        name: 'Flyer Drop',
        cost: 500,
        startDate: DateTime(2024, 3, 1),
        endDate: DateTime(2024, 3, 10),
      )..channel = AdChannel.print;

      final transactions = [_income('A', 100, DateTime(2024, 3, 5))];

      final result =
          ComputeAdCampaignRoi.call([campaign], transactions).single;

      expect(result.roi, closeTo(-0.8, 1e-9));
      expect(result.isPositiveRoi, isFalse);
    });

    test('sorts campaigns by ROI descending', () {
      final good = AdCampaignEntity(
        name: 'Good',
        cost: 100,
        startDate: DateTime(2024, 1, 1),
        endDate: DateTime(2024, 1, 10),
      );
      final bad = AdCampaignEntity(
        name: 'Bad',
        cost: 500,
        startDate: DateTime(2024, 2, 1),
        endDate: DateTime(2024, 2, 10),
      );
      final transactions = [
        _income('A', 300, DateTime(2024, 1, 5)),
        _income('B', 50, DateTime(2024, 2, 5)),
      ];

      final results = ComputeAdCampaignRoi.call([bad, good], transactions);
      expect(results.first.name, 'Good');
      expect(results.last.name, 'Bad');
    });
  });

  group('BuildAdCampaignRoiNarrative', () {
    test('falls back when no campaigns are logged', () {
      expect(BuildAdCampaignRoiNarrative.call(const []),
          contains('No campaigns logged'));
    });

    test('names the best and worst performer when multiple exist', () {
      final good = AdCampaignEntity(
        name: 'Good',
        cost: 100,
        startDate: DateTime(2024, 1, 1),
        endDate: DateTime(2024, 1, 10),
      );
      final bad = AdCampaignEntity(
        name: 'Bad',
        cost: 500,
        startDate: DateTime(2024, 2, 1),
        endDate: DateTime(2024, 2, 10),
      );
      final transactions = [
        _income('A', 300, DateTime(2024, 1, 5)),
        _income('B', 50, DateTime(2024, 2, 5)),
      ];

      final results = ComputeAdCampaignRoi.call([bad, good], transactions);
      final narrative = BuildAdCampaignRoiNarrative.call(results);
      expect(narrative, contains('Good'));
      expect(narrative, contains('Bad'));
    });
  });
}
