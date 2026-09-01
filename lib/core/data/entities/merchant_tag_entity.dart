import 'package:objectbox/objectbox.dart';

/// One custom tag assigned to a merchant (Issue #342) — a lightweight
/// append-only assignment log, so a merchant may end up with the same
/// tag logged more than once; [merchantBusinessId] links back to
/// [MerchantConfigEntity.businessId] (Issue #338), this app's merchant
/// directory.
@Entity()
class MerchantTagEntity {
  @Id()
  int id = 0;

  String merchantBusinessId;

  String tagLabel;

  @Index()
  @Property(type: PropertyType.date)
  DateTime taggedAt;

  MerchantTagEntity({
    this.id = 0,
    required this.merchantBusinessId,
    required this.tagLabel,
    required this.taggedAt,
  });
}
