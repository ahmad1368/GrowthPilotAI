import 'package:growth_pilot_ai/core/data/entities/strike_entity.dart';
import 'package:growth_pilot_ai/core/enum/moderation_reason.dart';

/// Builds a strike record (Issue #124) — [isCritical] strikes never
/// expire; others carry the 90-day TTL from the "Strike Counter & TTL"
/// scope item.
class RegisterStrike {
  static const ttl = Duration(days: 90);

  static StrikeEntity call({
    required String targetId,
    required ModerationReason reason,
    required DateTime now,
    bool isCritical = false,
  }) {
    return StrikeEntity(
      targetId: targetId,
      dbReason: reason.index,
      isCritical: isCritical,
      createdAt: now,
      expiresAt: isCritical ? null : now.add(ttl),
    );
  }
}
