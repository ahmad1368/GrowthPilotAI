import 'package:growth_pilot_ai/business/count_active_strikes.dart';
import 'package:growth_pilot_ai/core/data/entities/strike_entity.dart';

/// "Strike Logic" AC (Issue #124): 3 active strikes auto-suspends the
/// profile's verification level. Named distinctly from the unrelated
/// `IsAccountSuspended` (Issue #341, merchant transactional-access lock).
class IsProfileSuspended {
  static const suspensionThreshold = 3;

  static bool call(List<StrikeEntity> strikes, String targetId, DateTime now) =>
      CountActiveStrikes.call(strikes, targetId, now) >= suspensionThreshold;
}
