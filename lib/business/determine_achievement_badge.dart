import 'package:growth_pilot_ai/core/enum/achievement_badge_tier.dart';

/// Milestone tier from a completed-recommendation count (Issue #260's
/// "Achievement badges (Bronze, Silver, Gold)"). Thresholds are this
/// pipeline's own reasonable default — the issue does not specify exact
/// counts.
class DetermineAchievementBadge {
  static AchievementBadgeTier call(int completedCount) {
    if (completedCount >= 25) return AchievementBadgeTier.gold;
    if (completedCount >= 10) return AchievementBadgeTier.silver;
    if (completedCount >= 3) return AchievementBadgeTier.bronze;
    return AchievementBadgeTier.none;
  }
}
