import 'package:growth_pilot_ai/core/data/entities/linked_account_entity.dart';
import 'package:growth_pilot_ai/core/models/institution_account_group.dart';

/// Groups [LinkedAccountEntity] rows by institution for the Connected
/// Accounts screen's accordion list (Issue #68), preserving first-seen
/// institution order.
class GroupAccountsByInstitution {
  static List<InstitutionAccountGroup> call(List<LinkedAccountEntity> accounts) {
    final byInstitution = <String, List<LinkedAccountEntity>>{};
    for (final account in accounts) {
      byInstitution.putIfAbsent(account.institutionName, () => []).add(account);
    }
    return byInstitution.entries
        .map((e) => InstitutionAccountGroup(
              institutionName: e.key,
              accounts: e.value,
            ))
        .toList();
  }
}
