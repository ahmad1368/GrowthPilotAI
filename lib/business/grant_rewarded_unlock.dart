import 'package:growth_pilot_ai/business/generate_ad_completion_token.dart';
import 'package:growth_pilot_ai/core/data/entities/rewarded_unlock_entity.dart';

/// Builds a time-bound unlock record after a rewarded promo completes
/// (Issue #405, acceptance criterion 2) — pure construction, the caller
/// persists the result via [RewardedUnlockRepository.record].
class GrantRewardedUnlock {
  static RewardedUnlockEntity call({
    required String moduleName,
    required String merchantName,
    required Duration duration,
    required DateTime now,
  }) {
    return RewardedUnlockEntity(
      moduleName: moduleName,
      merchantName: merchantName,
      completionToken: GenerateAdCompletionToken.call(),
      unlockedAt: now,
      expiresAt: now.add(duration),
    );
  }
}
