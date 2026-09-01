import 'package:growth_pilot_ai/core/models/token_lifecycle.dart';

/// The QuickBooks token "heartbeat": decides — before an API call — whether the
/// access token should be silently refreshed, or the refresh token has expired
/// and the user must re-connect their account.
class TokenManager {
  /// Refresh a little before the access token actually expires.
  static const Duration refreshSkew = Duration(minutes: 5);

  static bool needsRefresh(TokenLifecycle token, DateTime now) =>
      !now.isBefore(token.accessExpiresAt.subtract(refreshSkew));

  /// True once the refresh token itself has expired — a silent refresh can no
  /// longer help, so the user must re-authorize ("Re-connect Required").
  static bool requiresReconnect(TokenLifecycle token, DateTime now) =>
      !now.isBefore(token.refreshExpiresAt);
}
