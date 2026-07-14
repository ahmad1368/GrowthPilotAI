import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/transaction_mapper.dart';
import 'package:growth_pilot_ai/core/data/entities/mapping_rule_entity.dart';
import 'package:growth_pilot_ai/core/models/chart_of_account.dart';
import 'package:growth_pilot_ai/core/models/mapping_result.dart';

void main() {
  final rules = [
    MappingRuleEntity(
      merchantPattern: 'shell',
      targetAccountId: 'acc-fuel',
      targetAccountName: 'Travel: Fuel',
    ),
  ];
  final accounts = [
    const ChartOfAccount(
      accountId: 'acc-meals',
      accountName: 'Meals & Entertainment',
      accountType: 'Expense',
    ),
  ];

  group('TransactionMapper.map', () {
    test('a saved rule wins with full confidence', () {
      final result = TransactionMapper.map(
        merchantName: 'Shell Gas Station',
        rawCategory: 'Food & Drink',
        rules: rules,
        chartOfAccounts: accounts,
      );
      expect(result.suggestedAccountId, 'acc-fuel');
      expect(result.confidence, 1.0);
      expect(result.source, MappingSource.userRule);
      expect(result.needsReview, isFalse);
    });

    test('falls back to fuzzy matching when no rule applies', () {
      final result = TransactionMapper.map(
        merchantName: 'Starbucks',
        rawCategory: 'Food & Drink',
        rules: rules,
        chartOfAccounts: accounts,
      );
      expect(result.suggestedAccountId, 'acc-meals');
      expect(result.source, MappingSource.fuzzyMatch);
    });

    test('flags low-confidence fuzzy matches as needing review', () {
      final result = TransactionMapper.map(
        merchantName: 'Random Merchant',
        rawCategory: 'Zzz Unrelated Xyz',
        rules: rules,
        chartOfAccounts: accounts,
      );
      expect(result.needsReview, isTrue);
    });
  });
}
