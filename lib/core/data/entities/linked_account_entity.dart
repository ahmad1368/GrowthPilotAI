import 'package:objectbox/objectbox.dart';

/// One bank/accounting sub-account under a linked institution (Issue #68),
/// e.g. a Chequing account or a Credit Card pulled in by a single Plaid
/// Link session. [isActive] gates whether it should sync transactions.
@Entity()
class LinkedAccountEntity {
  @Id()
  int id = 0;

  @Unique()
  String accountId; // Plaid-style sub-account id

  String institutionName; // e.g. "TD Canada Trust"
  String officialName; // e.g. "TD Business Chequing"
  String mask; // last 4 digits only — never the full account number
  String accountType; // 'depository' | 'credit'
  double currentBalance;
  bool isActive;
  bool needsReauth; // Plaid ITEM_LOGIN_REQUIRED

  LinkedAccountEntity({
    this.id = 0,
    required this.accountId,
    required this.institutionName,
    required this.officialName,
    required this.mask,
    required this.accountType,
    required this.currentBalance,
    this.isActive = true,
    this.needsReauth = false,
  });
}
