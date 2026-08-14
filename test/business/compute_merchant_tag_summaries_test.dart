import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_bulk_tag_assignments.dart';
import 'package:growth_pilot_ai/business/build_merchant_tag_narrative.dart';
import 'package:growth_pilot_ai/business/compute_merchant_tag_summaries.dart';
import 'package:growth_pilot_ai/business/filter_merchants_by_tag.dart';
import 'package:growth_pilot_ai/core/data/entities/merchant_config_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/merchant_tag_entity.dart';

MerchantConfigEntity _config({
  String businessName = 'Acme Foods',
  String businessId = 'ACM-001',
}) =>
    MerchantConfigEntity(
      businessName: businessName,
      businessId: businessId,
      commissionRatePercent: 5,
      transactionCapAmount: 10000,
      updatedAt: DateTime(2024, 3, 1),
    );

MerchantTagEntity _tag(String businessId, String tagLabel) => MerchantTagEntity(
      merchantBusinessId: businessId,
      tagLabel: tagLabel,
      taggedAt: DateTime(2024, 3, 1),
    );

void main() {
  group('ComputeMerchantTagSummaries', () {
    test('every merchant appears even with no tags', () {
      final results = ComputeMerchantTagSummaries.call([_config()], const []);

      expect(results.single.tags, isEmpty);
    });

    test('collapses duplicate tags logged for the same merchant', () {
      final results = ComputeMerchantTagSummaries.call(
          [_config(businessId: 'ACM-001')],
          [_tag('ACM-001', 'Budget'), _tag('ACM-001', 'Budget')]);

      expect(results.single.tags, ['Budget']);
    });

    test('sorts merchants alphabetically by business name', () {
      final results = ComputeMerchantTagSummaries.call([
        _config(businessName: 'Zeta', businessId: 'Z'),
        _config(businessName: 'Alpha', businessId: 'A'),
      ], const []);

      expect(results.first.businessName, 'Alpha');
    });
  });

  group('FilterMerchantsByTag', () {
    test('returns everything for a blank query', () {
      final summaries = ComputeMerchantTagSummaries.call([_config()], const []);

      expect(FilterMerchantsByTag.call(summaries, ''), summaries);
    });

    test('matches only merchants carrying the exact tag, case-insensitively', () {
      final summaries = ComputeMerchantTagSummaries.call(
          [_config(businessId: 'ACM-001'), _config(businessName: 'Other', businessId: 'OTH')],
          [_tag('ACM-001', 'High-Risk')]);

      final filtered = FilterMerchantsByTag.call(summaries, 'high-risk');
      expect(filtered, hasLength(1));
      expect(filtered.single.businessId, 'ACM-001');
    });
  });

  group('BuildBulkTagAssignments', () {
    test('builds one assignment per selected merchant', () {
      final assignments =
          BuildBulkTagAssignments.call(['A', 'B'], 'East Van', DateTime(2024, 3, 1));

      expect(assignments, hasLength(2));
      expect(assignments.every((a) => a.tagLabel == 'East Van'), isTrue);
    });
  });

  group('BuildMerchantTagNarrative', () {
    test('falls back when no merchant profiles exist', () {
      expect(BuildMerchantTagNarrative.call(const []),
          contains('No merchant profiles to tag'));
    });

    test('counts merchants carrying at least one tag', () {
      final summaries = ComputeMerchantTagSummaries.call(
          [_config(businessId: 'ACM-001'), _config(businessName: 'Other', businessId: 'OTH')],
          [_tag('ACM-001', 'Budget')]);

      expect(BuildMerchantTagNarrative.call(summaries), contains('1 of 2'));
    });
  });
}
