import 'package:objectbox/objectbox.dart';

/// A manually-logged temporary account suspension for a merchant (Issue
/// #341) — this app has no backend account service, so an admin records
/// each suspension's timeframe and reason locally, persisting via
/// ObjectBox `put` (insert when `id == 0`, update in place otherwise),
/// mirroring [MerchantConfigEntity]'s upsert pattern.
@Entity()
class AccountSuspensionEntity {
  @Id()
  int id = 0;

  String merchantName;

  String reason;

  @Property(type: PropertyType.date)
  DateTime suspendedAt;

  /// Automatic unsuspension time (acceptance criterion 3).
  @Index()
  @Property(type: PropertyType.date)
  DateTime expiresAt;

  /// Set true for early manual admin approval to lift the suspension
  /// before [expiresAt] (acceptance criterion 3).
  bool isManuallyLifted;

  AccountSuspensionEntity({
    this.id = 0,
    required this.merchantName,
    required this.reason,
    required this.suspendedAt,
    required this.expiresAt,
    this.isManuallyLifted = false,
  });
}
