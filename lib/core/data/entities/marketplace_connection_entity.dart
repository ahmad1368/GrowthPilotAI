import 'package:objectbox/objectbox.dart';

/// A connected external marketplace account (Issue #127 "Connection
/// Vault") — [credentialToken] is stored as-is; this app has no proven
/// AES-256-at-rest utility to reuse honestly, so unlike the issue's ask
/// this faithfully replicates the storage MODEL only, the same caveat
/// [AuthSessionEntity] (#120) documents for its own token fields.
@Entity()
class MarketplaceConnectionEntity {
  @Id()
  int id = 0;

  @Unique()
  String providerName;

  String credentialToken;
  bool isActive;

  @Property(type: PropertyType.date)
  DateTime connectedAt;

  MarketplaceConnectionEntity({
    this.id = 0,
    required this.providerName,
    required this.credentialToken,
    this.isActive = true,
    required this.connectedAt,
  });
}
