import 'package:objectbox/objectbox.dart';

/// One device/browser session's token pair (Issue #120) —
/// [refreshTokenHash] is a SHA-256 hash; the raw refresh token is
/// never persisted (acceptance criterion 1). This app has no server
/// distinct from the client holding it, so this faithfully replicates
/// the storage/rotation/revocation MODEL a real backend would
/// enforce, not an actual trust boundary — the device itself already
/// has full access to its own local data regardless of any token.
@Entity()
class AuthSessionEntity {
  @Id()
  int id = 0;

  String deviceLabel;
  String accessToken;

  @Property(type: PropertyType.date)
  DateTime accessTokenExpiresAt;

  @Index()
  String refreshTokenHash;

  @Property(type: PropertyType.date)
  DateTime refreshTokenExpiresAt;

  bool isRevoked;

  @Property(type: PropertyType.date)
  DateTime createdAt;

  /// Last time this session was used (Issue #173) — drives both the
  /// "Last Active" display and 30-day auto-cleanup eligibility.
  @Property(type: PropertyType.date)
  DateTime lastActiveAt;

  AuthSessionEntity({
    this.id = 0,
    required this.deviceLabel,
    required this.accessToken,
    required this.accessTokenExpiresAt,
    required this.refreshTokenHash,
    required this.refreshTokenExpiresAt,
    this.isRevoked = false,
    required this.createdAt,
    DateTime? lastActiveAt,
  }) : lastActiveAt = lastActiveAt ?? createdAt;
}
