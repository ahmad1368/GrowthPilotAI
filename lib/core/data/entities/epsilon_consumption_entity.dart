import 'package:objectbox/objectbox.dart';

/// Cumulative Differential Privacy "Privacy Budget" spend for one
/// user/session (Issue #81) — the audit trail that lets
/// [IsPrivacyBudgetExhausted] block "Budget Exhaustion" attacks (the
/// same query repeated many times to average out independent noise
/// draws).
@Entity()
class EpsilonConsumptionEntity {
  @Id()
  int id = 0;

  @Unique()
  String userId;

  double totalEpsilonSpent;

  @Property(type: PropertyType.date)
  DateTime updatedAt;

  EpsilonConsumptionEntity({
    this.id = 0,
    required this.userId,
    this.totalEpsilonSpent = 0,
    required this.updatedAt,
  });
}
