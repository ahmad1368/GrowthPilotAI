import 'package:growth_pilot_ai/core/data/entities/banner_matching_rule_entity.dart';

/// One-sentence read summarizing how many banner matching rules are
/// configured (Issue #403, acceptance criterion 4).
class BuildBannerRuleNarrative {
  static String call(List<BannerMatchingRuleEntity> rules) {
    if (rules.isEmpty) {
      return 'No matching rules configured yet — reports will show no contextual banner.';
    }
    final topRule = rules.reduce((a, b) => b.priorityWeight > a.priorityWeight ? b : a);
    return '${rules.length} matching rule(s) configured — highest priority: '
        '"${topRule.reportTopic}" → ${topRule.category} (weight ${topRule.priorityWeight}).';
  }
}
