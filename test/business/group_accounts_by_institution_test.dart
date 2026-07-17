import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/group_accounts_by_institution.dart';
import 'package:growth_pilot_ai/core/data/entities/linked_account_entity.dart';

void main() {
  LinkedAccountEntity account(String id, String institution) => LinkedAccountEntity(
        accountId: id,
        institutionName: institution,
        officialName: id,
        mask: '0000',
        accountType: 'depository',
        currentBalance: 0,
      );

  group('GroupAccountsByInstitution.call', () {
    test('groups accounts under their institution', () {
      final groups = GroupAccountsByInstitution.call([
        account('a1', 'TD Canada Trust'),
        account('a2', 'TD Canada Trust'),
        account('a3', 'Scotiabank'),
      ]);

      expect(groups.length, 2);
      final td = groups.firstWhere((g) => g.institutionName == 'TD Canada Trust');
      expect(td.accounts.map((a) => a.accountId), ['a1', 'a2']);
    });

    test('returns an empty list for no accounts', () {
      expect(GroupAccountsByInstitution.call([]), isEmpty);
    });
  });
}
