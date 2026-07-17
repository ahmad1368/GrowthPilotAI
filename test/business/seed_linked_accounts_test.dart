import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/seed_linked_accounts.dart';
import 'package:growth_pilot_ai/core/data/entities/linked_account_entity.dart';

void main() {
  group('SeedLinkedAccounts.call', () {
    test('seeds demo accounts across two institutions when none exist', () {
      final seeds = SeedLinkedAccounts.call([]);

      expect(seeds, isNotEmpty);
      expect(seeds.map((s) => s.institutionName).toSet(),
          {'TD Canada Trust', 'Scotiabank'});
    });

    test('does not seed anything when accounts already exist', () {
      final existing = [
        LinkedAccountEntity(
          accountId: 'x',
          institutionName: 'TD Canada Trust',
          officialName: 'TD Chequing',
          mask: '1111',
          accountType: 'depository',
          currentBalance: 100,
        ),
      ];

      expect(SeedLinkedAccounts.call(existing), isEmpty);
    });
  });
}
