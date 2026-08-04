/// A merchant's current suspension status (Issue #341): the latest
/// logged suspension and whether it's still actively blocking access —
/// active means neither manually lifted nor past its expiry timeframe.
class AccountSuspensionStatus {
  final int id;
  final String merchantName;
  final String reason;
  final DateTime suspendedAt;
  final DateTime expiresAt;
  final bool isManuallyLifted;
  final bool isActive;

  const AccountSuspensionStatus({
    required this.id,
    required this.merchantName,
    required this.reason,
    required this.suspendedAt,
    required this.expiresAt,
    required this.isManuallyLifted,
    required this.isActive,
  });
}
