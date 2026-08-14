import 'package:growth_pilot_ai/core/data/entities/rewarded_unlock_entity.dart';

/// One-sentence read naming the most recent rewarded unlock, for
/// advertiser verification and auditing (Issue #405, acceptance
/// criterion 5).
class BuildRewardedUnlockNarrative {
  static String call(List<RewardedUnlockEntity> unlocks) {
    if (unlocks.isEmpty) {
      return 'No rewarded promo unlocks logged yet.';
    }
    final latest = unlocks.reduce((a, b) => b.unlockedAt.isAfter(a.unlockedAt) ? b : a);
    return '${unlocks.length} rewarded unlock(s) logged — most recently '
        '${latest.merchantName} unlocked "${latest.moduleName}" until ${latest.expiresAt}.';
  }
}
