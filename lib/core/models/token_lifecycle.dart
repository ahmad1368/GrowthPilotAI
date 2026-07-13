import 'package:flutter/foundation.dart';

/// Expiry state of a QuickBooks OAuth session that the client tracks — only
/// timestamps, never the secret tokens (those stay encrypted server-side).
/// QBO access tokens live ~60 minutes; refresh tokens rotate every ~100 days.
@immutable
class TokenLifecycle {
  final DateTime accessExpiresAt;
  final DateTime refreshExpiresAt;

  const TokenLifecycle({
    required this.accessExpiresAt,
    required this.refreshExpiresAt,
  });

  factory TokenLifecycle.issuedAt(DateTime issuedAt) => TokenLifecycle(
        accessExpiresAt: issuedAt.add(const Duration(minutes: 60)),
        refreshExpiresAt: issuedAt.add(const Duration(days: 100)),
      );
}
