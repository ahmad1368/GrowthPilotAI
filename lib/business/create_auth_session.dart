import 'package:growth_pilot_ai/business/compute_access_token_expiry.dart';
import 'package:growth_pilot_ai/business/compute_refresh_token_expiry.dart';
import 'package:growth_pilot_ai/business/generate_access_token.dart';
import 'package:growth_pilot_ai/business/generate_refresh_token.dart';
import 'package:growth_pilot_ai/business/hash_refresh_token.dart';
import 'package:growth_pilot_ai/core/data/entities/auth_session_entity.dart';

/// Issues a fresh access/refresh token pair for a new session (Issue
/// #120) — returns both the persistable entity (refresh token
/// hashed) and the raw refresh token, which the caller must hand to
/// secure storage immediately since it's never recoverable from the
/// entity afterward.
class CreateAuthSession {
  static ({AuthSessionEntity session, String rawRefreshToken}) call(String deviceLabel, DateTime now) {
    final rawRefreshToken = GenerateRefreshToken.call();
    final accessExpiry = ComputeAccessTokenExpiry.call(now);
    final session = AuthSessionEntity(
      deviceLabel: deviceLabel,
      accessToken: GenerateAccessToken.call(deviceLabel, accessExpiry),
      accessTokenExpiresAt: accessExpiry,
      refreshTokenHash: HashRefreshToken.call(rawRefreshToken),
      refreshTokenExpiresAt: ComputeRefreshTokenExpiry.call(now),
      createdAt: now,
    );
    return (session: session, rawRefreshToken: rawRefreshToken);
  }
}
