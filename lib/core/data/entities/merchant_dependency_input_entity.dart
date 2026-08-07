import 'package:objectbox/objectbox.dart';

/// Admin-supplied inputs the dependency engine can't derive from
/// existing transactional data (Issue #424, acceptance criterion 2):
/// when a merchant's free trial began, and the admin-observed percent
/// of warehouse inventory they've liquidated/turned over — one record
/// per merchant, edited in place like [MerchantConfigEntity] (#338).
@Entity()
class MerchantDependencyInputEntity {
  @Id()
  int id = 0;

  @Index()
  String merchantName;

  @Property(type: PropertyType.date)
  DateTime trialStartedAt;

  double inventoryLiquidationPercent;

  @Property(type: PropertyType.date)
  DateTime updatedAt;

  MerchantDependencyInputEntity({
    this.id = 0,
    required this.merchantName,
    required this.trialStartedAt,
    this.inventoryLiquidationPercent = 0,
    required this.updatedAt,
  });
}
