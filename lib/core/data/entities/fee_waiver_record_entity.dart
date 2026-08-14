import 'package:objectbox/objectbox.dart';

/// A commission calculation/waiver decision for one completed
/// marketplace transaction (Issue #420) — a companion ledger rather
/// than a field added to [WholesaleOrderEntity] (#411), so the
/// existing checkout flow stays untouched and this is purely
/// additive reporting/decisioning.
@Entity()
class FeeWaiverRecordEntity {
  @Id()
  int id = 0;

  @Index()
  int orderId;

  @Index()
  String merchantName;

  double grossAmount;
  double commissionRate;
  double commissionAmount;
  double waivedAmount;
  bool isWaived;

  @Property(type: PropertyType.date)
  DateTime recordedAt;

  FeeWaiverRecordEntity({
    this.id = 0,
    required this.orderId,
    required this.merchantName,
    required this.grossAmount,
    required this.commissionRate,
    required this.commissionAmount,
    required this.waivedAmount,
    required this.isWaived,
    required this.recordedAt,
  });
}
