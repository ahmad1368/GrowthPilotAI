import 'package:objectbox/objectbox.dart';

/// One immutable record of a merchant temporarily unlocking a locked
/// feature module by completing a rewarded promo (Issue #405,
/// acceptance criteria 2 and 5) — this app has no ad-network SDK, so ad
/// completion is verified locally via [completionToken], and
/// [RewardedUnlockRepository] exposes no update/delete so the audit
/// trail can never be altered after the fact.
@Entity()
class RewardedUnlockEntity {
  @Id()
  int id = 0;

  String moduleName;

  String merchantName;

  String completionToken;

  @Property(type: PropertyType.date)
  DateTime unlockedAt;

  @Index()
  @Property(type: PropertyType.date)
  DateTime expiresAt;

  RewardedUnlockEntity({
    this.id = 0,
    required this.moduleName,
    required this.merchantName,
    required this.completionToken,
    required this.unlockedAt,
    required this.expiresAt,
  });
}
