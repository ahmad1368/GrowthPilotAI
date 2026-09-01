import 'package:growth_pilot_ai/business/check_module_route_access.dart';
import 'package:growth_pilot_ai/business/is_feature_temporarily_unlocked.dart';
import 'package:growth_pilot_ai/core/data/entities/feature_module_toggle_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/rewarded_unlock_entity.dart';

/// Extends the Modular Feature Toggle Engine's route gate (#339) with a
/// rewarded-unlock bypass (Issue #405, acceptance criterion 2) — a
/// route disabled by an admin toggle is still reachable for a merchant
/// holding an active, non-expired rewarded unlock for that module.
class CheckModuleAccessWithRewards {
  static bool call(
    List<FeatureModuleToggleEntity> toggles,
    List<RewardedUnlockEntity> unlocks,
    String? routeName,
    String merchantName,
    DateTime now,
  ) {
    if (CheckModuleRouteAccess.call(toggles, routeName)) return true;
    final toggle = toggles.where((t) => t.routeName == routeName);
    if (toggle.isEmpty) return false;
    return IsFeatureTemporarilyUnlocked.call(
        unlocks, toggle.first.moduleName, merchantName, now);
  }
}
