import 'package:growth_pilot_ai/business/create_auth_session.dart';
import 'package:growth_pilot_ai/business/is_session_token_expired.dart';
import 'package:growth_pilot_ai/business/touch_session_activity.dart';
import 'package:growth_pilot_ai/core/data/entities/auth_session_entity.dart';

/// Refresh Token Rotation (Issue #120) — a valid, unexpired,
/// unrevoked refresh token mints a brand-new access/refresh pair,
/// invalidating the old one, so a stolen refresh token can only be
/// used once before its reuse is detectable.
class RotateAuthSession {
  static ({AuthSessionEntity session, String rawRefreshToken})? call(
    AuthSessionEntity oldSession,
    DateTime now,
  ) {
    if (oldSession.isRevoked) return null;
    if (IsSessionTokenExpired.call(oldSession.refreshTokenExpiresAt, now)) return null;
    TouchSessionActivity.call(oldSession, now);
    return CreateAuthSession.call(oldSession.deviceLabel, now);
  }
}
