import 'package:growth_pilot_ai/core/data/entities/mapping_rule_entity.dart';

/// Level 1 of the mapping engine (Issue #57): user-saved "Auto-Map Rules",
/// checked before any fuzzy matching. First rule whose pattern the merchant
/// name contains (case-insensitive) wins — deterministic, full confidence.
class MappingRuleMatcher {
  static MappingRuleEntity? findMatch(
    List<MappingRuleEntity> rules,
    String merchantName,
  ) {
    final needle = merchantName.toLowerCase();
    for (final rule in rules) {
      if (needle.contains(rule.merchantPattern.toLowerCase())) return rule;
    }
    return null;
  }
}
