import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/calculate_combined_balance.dart';
import 'package:growth_pilot_ai/core/data/entities/linked_account_entity.dart';

void main() {
  LinkedAccountEntity account(double balance, {bool isActive = true}) =>
      LinkedAccountEntity(
        accountId: balance.toString(),
        institutionName: 'Bank',
        officialName: 'Account',
        mask: '0000',
        accountType: 'depository',
        currentBalance: balance,
        isActive: isActive,
      );

  group('CalculateCombinedBalance.call', () {
    test('sums only active accounts', () {
      final total = CalculateCombinedBalance.call([
        account(100),
        account(-40),
        account(5000, isActive: false),
      ]);

      expect(total, 60);
    });

    test('returns 0 for an empty list', () {
      expect(CalculateCombinedBalance.call([]), 0);
    });
  });
}
