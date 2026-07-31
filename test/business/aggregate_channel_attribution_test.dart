import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/aggregate_channel_attribution.dart';
import 'package:growth_pilot_ai/business/build_channel_attribution_narrative.dart';
import 'package:growth_pilot_ai/business/compute_ad_campaign_roi.dart';
import 'package:growth_pilot_ai/core/data/entities/ad_campaign_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';

TransactionEntity _income(String description, double amount, DateTime date) =>
    TransactionEntity(
        amount: amount, description: description, date: date, dbType: 1);

void main() {
  group('AggregateChannelAttribution', () {
    test('returns empty list when no campaigns are logged', () {
      expect(AggregateChannelAttribution.call(const []), isEmpty);
    });

    test('rolls up multiple campaigns on the same channel', () {
      final campaigns = [
        AdCampaignEntity(
          name: 'Digital A',
          cost: 100,
          startDate: DateTime(2024, 1, 1),
          endDate: DateTime(2024, 1, 10),
        )..channel = AdChannel.digital,
        AdCampaignEntity(
          name: 'Digital B',
          cost: 100,
          startDate: DateTime(2024, 2, 1),
          endDate: DateTime(2024, 2, 10),
        )..channel = AdChannel.digital,
      ];
      final transactions = [
        _income('A', 200, DateTime(2024, 1, 5)),
        _income('B', 100, DateTime(2024, 2, 5)),
      ];

      final campaignRois = ComputeAdCampaignRoi.call(campaigns, transactions);
      final result = AggregateChannelAttribution.call(campaignRois).single;

      expect(result.channel, AdChannel.digital);
      expect(result.campaignCount, 2);
      expect(result.totalCost, 200);
      expect(result.totalAttributedRevenue, 300);
      expect(result.totalNewCustomers, 2);
      expect(result.costPerAcquisition, 100);
      expect(result.roi, closeTo(0.5, 1e-9));
      expect(result.isPositiveRoi, isTrue);
    });

    test('excludes channels with no logged campaigns', () {
      final campaign = AdCampaignEntity(
        name: 'Digital A',
        cost: 100,
        startDate: DateTime(2024, 1, 1),
        endDate: DateTime(2024, 1, 10),
      )..channel = AdChannel.digital;

      final campaignRois = ComputeAdCampaignRoi.call([campaign], const []);
      final results = AggregateChannelAttribution.call(campaignRois);

      expect(results, hasLength(1));
      expect(results.single.channel, AdChannel.digital);
    });

    test('sorts channels by ROI descending', () {
      final good = AdCampaignEntity(
        name: 'Good',
        cost: 100,
        startDate: DateTime(2024, 1, 1),
        endDate: DateTime(2024, 1, 10),
      )..channel = AdChannel.digital;
      final bad = AdCampaignEntity(
        name: 'Bad',
        cost: 500,
        startDate: DateTime(2024, 2, 1),
        endDate: DateTime(2024, 2, 10),
      )..channel = AdChannel.print;
      final transactions = [
        _income('A', 300, DateTime(2024, 1, 5)),
        _income('B', 50, DateTime(2024, 2, 5)),
      ];

      final campaignRois =
          ComputeAdCampaignRoi.call([bad, good], transactions);
      final results = AggregateChannelAttribution.call(campaignRois);

      expect(results.first.channel, AdChannel.digital);
      expect(results.last.channel, AdChannel.print);
    });
  });

  group('BuildChannelAttributionNarrative', () {
    test('falls back when no campaigns are logged', () {
      expect(BuildChannelAttributionNarrative.call(const []),
          contains('No ad campaigns logged'));
    });

    test('names the best and worst channel when multiple exist', () {
      final good = AdCampaignEntity(
        name: 'Good',
        cost: 100,
        startDate: DateTime(2024, 1, 1),
        endDate: DateTime(2024, 1, 10),
      )..channel = AdChannel.digital;
      final bad = AdCampaignEntity(
        name: 'Bad',
        cost: 500,
        startDate: DateTime(2024, 2, 1),
        endDate: DateTime(2024, 2, 10),
      )..channel = AdChannel.print;
      final transactions = [
        _income('A', 300, DateTime(2024, 1, 5)),
        _income('B', 50, DateTime(2024, 2, 5)),
      ];

      final campaignRois =
          ComputeAdCampaignRoi.call([bad, good], transactions);
      final results = AggregateChannelAttribution.call(campaignRois);
      final narrative = BuildChannelAttributionNarrative.call(results);

      expect(narrative, contains('digital'));
      expect(narrative, contains('print'));
    });
  });
}
