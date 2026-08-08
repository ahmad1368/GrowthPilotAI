import 'package:growth_pilot_ai/core/data/entities/strike_entity.dart';

/// Non-expired strikes against [targetId] (Issue #124) — critical
/// strikes always count; others only while within their TTL.
class CountActiveStrikes {
  static int call(List<StrikeEntity> strikes, String targetId, DateTime now) {
    return strikes
        .where((s) =>
            s.targetId == targetId && (s.isCritical || s.expiresAt!.isAfter(now)))
        .length;
  }
}
