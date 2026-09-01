import 'package:objectbox/objectbox.dart';

/// "Secure QR Handshake" (Issue #155) — a time-sensitive token the
/// buyer's app displays and the seller scans to release payment (#147).
/// Verification is a pure local comparison ([IsHandshakeTokenValid]),
/// so it works offline in low-connectivity loading docks per the AC;
/// only the resulting [used] flag needs a later "Sync-Later" write.
@Entity()
class DeliveryHandshakeEntity {
  @Id()
  int id = 0;

  @Unique()
  int deliveryId;

  String token;
  bool used;

  @Property(type: PropertyType.date)
  DateTime expiresAt;

  @Property(type: PropertyType.date)
  DateTime createdAt;

  DeliveryHandshakeEntity({
    this.id = 0,
    required this.deliveryId,
    required this.token,
    this.used = false,
    required this.expiresAt,
    required this.createdAt,
  });
}
