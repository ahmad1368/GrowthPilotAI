import 'package:flutter/foundation.dart';
import 'package:growth_pilot_ai/core/data/entities/linked_account_entity.dart';

/// All sub-accounts pulled in by one institution's Link session (Issue #68),
/// for the Connected Accounts screen's grouped list.
@immutable
class InstitutionAccountGroup {
  final String institutionName;
  final List<LinkedAccountEntity> accounts;

  const InstitutionAccountGroup({
    required this.institutionName,
    required this.accounts,
  });
}
