import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_financial_health.dart';
import 'package:growth_pilot_ai/core/data/entities/linked_account_entity.dart';

LinkedAccountEntity _account(
  String type,
  double balance, {
  bool isActive = true,
  String id = 'a1',
}) =>
    LinkedAccountEntity(
      accountId: id,
      institutionName: 'Bank',
      officialName: 'Account',
      mask: '0000',
      accountType: type,
      currentBalance: balance,
      isActive: isActive,
    );

void main() {
  test('sums depository balances as assets and credit balances as liabilities', () {
    final health = ComputeFinancialHealth.call([
      _account('depository', 2000, id: 'a1'),
      _account('credit', 500, id: 'a2'),
    ]);

    expect(health.currentAssets, 2000);
    expect(health.currentLiabilities, 500);
    expect(health.workingCapital, 1500);
  });

  test('a current ratio of 2.0 or more scores exactly 100', () {
    final health = ComputeFinancialHealth.call([
      _account('depository', 2000, id: 'a1'),
      _account('credit', 1000, id: 'a2'),
    ]);

    expect(health.currentRatio, 2.0);
    expect(health.healthScore, 100);
  });

  test('no liabilities but positive assets caps the ratio at the healthy ceiling', () {
    final health = ComputeFinancialHealth.call([_account('depository', 500, id: 'a1')]);

    expect(health.currentRatio, 2.0);
    expect(health.healthScore, 100);
  });

  test('inactive accounts are excluded from both assets and liabilities', () {
    final health = ComputeFinancialHealth.call([
      _account('depository', 2000, id: 'a1', isActive: false),
      _account('credit', 500, id: 'a2', isActive: false),
    ]);

    expect(health.currentAssets, 0);
    expect(health.currentLiabilities, 0);
  });

  test('no accounts at all is a zero score', () {
    final health = ComputeFinancialHealth.call([]);
    expect(health.healthScore, 0);
  });
}
