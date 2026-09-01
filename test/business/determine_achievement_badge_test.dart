import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/determine_achievement_badge.dart';
import 'package:growth_pilot_ai/core/enum/achievement_badge_tier.dart';

void main() {
  group('DetermineAchievementBadge', () {
    test('no badge below the bronze threshold', () {
      expect(DetermineAchievementBadge.call(2), AchievementBadgeTier.none);
    });

    test('bronze at the threshold', () {
      expect(DetermineAchievementBadge.call(3), AchievementBadgeTier.bronze);
    });

    test('silver at the threshold', () {
      expect(DetermineAchievementBadge.call(10), AchievementBadgeTier.silver);
    });

    test('gold at the threshold', () {
      expect(DetermineAchievementBadge.call(25), AchievementBadgeTier.gold);
    });
  });
}
