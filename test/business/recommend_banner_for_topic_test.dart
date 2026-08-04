import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_banner_rule_narrative.dart';
import 'package:growth_pilot_ai/business/recommend_banner_for_topic.dart';
import 'package:growth_pilot_ai/core/data/entities/advertising_request_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/banner_matching_rule_entity.dart';
import 'package:growth_pilot_ai/core/enum/ad_request_status.dart';

BannerMatchingRuleEntity _rule({
  String reportTopic = 'profit margin',
  String category = 'grocery',
  int priorityWeight = 1,
}) =>
    BannerMatchingRuleEntity(
      reportTopic: reportTopic,
      category: category,
      priorityWeight: priorityWeight,
      updatedAt: DateTime(2024, 3, 1),
    );

AdvertisingRequestEntity _request({
  String merchantName = 'Acme Foods',
  String category = 'grocery',
  AdRequestStatus status = AdRequestStatus.approved,
}) {
  final request = AdvertisingRequestEntity(
    merchantName: merchantName,
    category: category,
    dbPackageType: 0,
    requestedAt: DateTime(2024, 3, 1),
  );
  request.status = status;
  return request;
}

void main() {
  group('RecommendBannerForTopic', () {
    test('returns null when no rule matches the topic', () {
      final result = RecommendBannerForTopic.call(
          [_rule(reportTopic: 'inflation')], [_request()], 'profit margin');

      expect(result, isNull);
    });

    test('matches a request via the rule category for a matching topic', () {
      final result = RecommendBannerForTopic.call(
          [_rule(reportTopic: 'profit margin', category: 'grocery')],
          [_request(category: 'grocery')],
          'profit margin');

      expect(result!.merchantName, 'Acme Foods');
    });

    test('ignores requests that are not approved', () {
      final result = RecommendBannerForTopic.call(
          [_rule()], [_request(status: AdRequestStatus.pending)], 'profit margin');

      expect(result, isNull);
    });

    test('prefers the highest priority-weight matching rule', () {
      final result = RecommendBannerForTopic.call(
          [
            _rule(category: 'bakery', priorityWeight: 1),
            _rule(category: 'grocery', priorityWeight: 5),
          ],
          [
            _request(merchantName: 'Bakery Co', category: 'bakery'),
            _request(merchantName: 'Grocery Co', category: 'grocery'),
          ],
          'profit margin');

      expect(result!.merchantName, 'Grocery Co');
    });
  });

  group('BuildBannerRuleNarrative', () {
    test('falls back when no rules are configured', () {
      expect(BuildBannerRuleNarrative.call(const []), contains('No matching rules'));
    });

    test('names the highest priority rule', () {
      final narrative = BuildBannerRuleNarrative.call(
          [_rule(reportTopic: 'inflation', category: 'bakery', priorityWeight: 9)]);

      expect(narrative, contains('inflation'));
      expect(narrative, contains('bakery'));
    });
  });
}
