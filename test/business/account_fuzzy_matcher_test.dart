import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/account_fuzzy_matcher.dart';
import 'package:growth_pilot_ai/core/models/chart_of_account.dart';

void main() {
  final accounts = [
    const ChartOfAccount(
      accountId: 'a1',
      accountName: 'Meals & Entertainment',
      accountType: 'Expense',
    ),
    const ChartOfAccount(
      accountId: 'a2',
      accountName: 'Travel: Fuel',
      accountType: 'Expense',
    ),
  ];

  group('AccountFuzzyMatcher.findBestMatch', () {
    test('picks the closest account name for a related raw category', () {
      final result = AccountFuzzyMatcher.findBestMatch('Food & Drink', accounts);
      expect(result.account?.accountId, 'a1');
      expect(result.confidence, greaterThan(0.0));
    });

    test('returns null account and 0 confidence for an empty account list', () {
      final result = AccountFuzzyMatcher.findBestMatch('Food & Drink', []);
      expect(result.account, isNull);
      expect(result.confidence, 0.0);
    });
  });
}
