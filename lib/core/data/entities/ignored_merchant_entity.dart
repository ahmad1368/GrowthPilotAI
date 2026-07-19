import 'package:objectbox/objectbox.dart';

/// A merchant the user dismissed via "Ignore for this Merchant" on an
/// anomaly alert (Issue #74) — suppresses future Z-score/velocity alerts
/// for it ("False Positive Management").
@Entity()
class IgnoredMerchantEntity {
  @Id()
  int id = 0;

  @Index()
  String merchantName;
  DateTime ignoredAt;

  IgnoredMerchantEntity({
    this.id = 0,
    required this.merchantName,
    DateTime? ignoredAt,
  }) : ignoredAt = ignoredAt ?? DateTime.now();
}
