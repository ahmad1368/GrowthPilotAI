import 'package:growth_pilot_ai/core/data/entities/advertising_request_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/banner_matching_rule_entity.dart';
import 'package:growth_pilot_ai/core/enum/ad_request_status.dart';

/// Correlates an analytical report's topic with a matching approved
/// advertising request via admin-configured rules, highest priority
/// weight first (Issue #403, acceptance criteria 1 and 4) — returns
/// null when nothing matches so an irrelevant banner is never forced
/// onto the report (acceptance criterion 5).
class RecommendBannerForTopic {
  static AdvertisingRequestEntity? call(
    List<BannerMatchingRuleEntity> rules,
    List<AdvertisingRequestEntity> approvedRequests,
    String reportTopic,
  ) {
    final topic = reportTopic.toLowerCase();
    final matchingRules = rules.where((r) {
      final ruleTopic = r.reportTopic.toLowerCase();
      return topic.contains(ruleTopic) || ruleTopic.contains(topic);
    }).toList()
      ..sort((a, b) => b.priorityWeight.compareTo(a.priorityWeight));

    for (final rule in matchingRules) {
      final matches = approvedRequests.where(
          (r) => r.status == AdRequestStatus.approved && r.category == rule.category);
      if (matches.isNotEmpty) return matches.first;
    }
    return null;
  }
}
