import 'package:objectbox/objectbox.dart';

/// A user-defined "Auto-Map Rule" (Issue #57): merchants whose name contains
/// [merchantPattern] are auto-categorized to the given accounting-software
/// account, skipping fuzzy matching (Level 1 of the matching engine).
@Entity()
class MappingRuleEntity {
  @Id()
  int id = 0;

  @Index()
  String merchantPattern; // مثل: "Amazon" — تطبیق case-insensitive contains

  String targetAccountId;
  String targetAccountName; // مثل: "Office Supplies"

  MappingRuleEntity({
    this.id = 0,
    required this.merchantPattern,
    required this.targetAccountId,
    required this.targetAccountName,
  });
}
