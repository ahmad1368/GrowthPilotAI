import 'package:growth_pilot_ai/core/data/entities/rewarded_unlock_entity.dart';

/// Whether a merchant currently holds an active (non-expired) rewarded
/// unlock for a module (Issue #405, acceptance criterion 2) — expiry is
/// re-evaluated against [now] on every call, so access lapses on its
/// own without needing a background job.
class IsFeatureTemporarilyUnlocked {
  static bool call(
      List<RewardedUnlockEntity> unlocks, String moduleName, String merchantName, DateTime now) {
    return unlocks.any((u) =>
        u.moduleName == moduleName && u.merchantName == merchantName && now.isBefore(u.expiresAt));
  }
}
