import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/mapping_rule_matcher.dart';
import 'package:growth_pilot_ai/core/data/entities/mapping_rule_entity.dart';

void main() {
  final rules = [
    MappingRuleEntity(
      merchantPattern: 'amazon',
      targetAccountId: 'acc-1',
      targetAccountName: 'Office Supplies',
    ),
    MappingRuleEntity(
      merchantPattern: 'shell',
      targetAccountId: 'acc-2',
      targetAccountName: 'Travel: Fuel',
    ),
  ];

  group('MappingRuleMatcher.findMatch', () {
    test('matches a merchant name containing the pattern, ignoring case', () {
      final match = MappingRuleMatcher.findMatch(rules, 'SHELL GAS STATION');
      expect(match?.targetAccountId, 'acc-2');
    });

    test('returns null when no rule pattern is contained', () {
      expect(MappingRuleMatcher.findMatch(rules, 'Starbucks'), isNull);
    });

    test('returns the first matching rule when multiple could apply', () {
      final match = MappingRuleMatcher.findMatch(rules, 'Amazon Shell Co');
      expect(match?.targetAccountId, 'acc-1');
    });
  });
}
