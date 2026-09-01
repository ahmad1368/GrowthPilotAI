import 'package:growth_pilot_ai/business/account_fuzzy_matcher.dart';
import 'package:growth_pilot_ai/business/mapping_rule_matcher.dart';
import 'package:growth_pilot_ai/core/data/entities/mapping_rule_entity.dart';
import 'package:growth_pilot_ai/core/models/chart_of_account.dart';
import 'package:growth_pilot_ai/core/models/mapping_result.dart';
import 'package:growth_pilot_ai/core/utils/logger.dart';

/// Orchestrates Issue #57's mapping engine: a saved user rule wins outright
/// (confidence 1.0); otherwise falls back to fuzzy-matching the raw category
/// against the Chart of Accounts. Every auto-map is logged (rule id or
/// "fuzzy") for the required financial audit trail.
class TransactionMapper {
  static MappingResult map({
    required String merchantName,
    required String rawCategory,
    required List<MappingRuleEntity> rules,
    required List<ChartOfAccount> chartOfAccounts,
  }) {
    final rule = MappingRuleMatcher.findMatch(rules, merchantName);
    if (rule != null) {
      OmniLogger.info('Auto-mapped "$merchantName" via rule ${rule.id}');
      return MappingResult(
        suggestedAccountId: rule.targetAccountId,
        confidence: 1.0,
        source: MappingSource.userRule,
      );
    }

    final match =
        AccountFuzzyMatcher.findBestMatch(rawCategory, chartOfAccounts);
    OmniLogger.info(
      'Auto-mapped "$merchantName" via fuzzy match (confidence '
      '${match.confidence.toStringAsFixed(2)})',
    );
    return MappingResult(
      suggestedAccountId: match.account?.accountId,
      confidence: match.confidence,
      source: match.account == null
          ? MappingSource.none
          : MappingSource.fuzzyMatch,
    );
  }
}
