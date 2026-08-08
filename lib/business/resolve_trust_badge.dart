import 'package:growth_pilot_ai/core/enum/trust_badge.dart';

/// "Tiered Badge System" (Issue #135 AC): Elite > 9.0, Verified Pro > 7.5.
class ResolveTrustBadge {
  static TrustBadge call(double trustScore) {
    if (trustScore > 9.0) return TrustBadge.elite;
    if (trustScore > 7.5) return TrustBadge.verifiedPro;
    return TrustBadge.standard;
  }
}
