import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_rewarded_unlock_narrative.dart';
import 'package:growth_pilot_ai/business/check_module_access_with_rewards.dart';
import 'package:growth_pilot_ai/business/generate_ad_completion_token.dart';
import 'package:growth_pilot_ai/business/grant_rewarded_unlock.dart';
import 'package:growth_pilot_ai/business/is_feature_temporarily_unlocked.dart';
import 'package:growth_pilot_ai/core/data/entities/feature_module_toggle_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/rewarded_unlock_entity.dart';

final _now = DateTime(2024, 3, 10, 12, 0);

RewardedUnlockEntity _unlock({
  String moduleName = 'Analytics',
  String merchantName = 'Acme Foods',
  DateTime? unlockedAt,
  DateTime? expiresAt,
}) =>
    RewardedUnlockEntity(
      moduleName: moduleName,
      merchantName: merchantName,
      completionToken: 'abc123',
      unlockedAt: unlockedAt ?? _now,
      expiresAt: expiresAt ?? _now.add(const Duration(minutes: 15)),
    );

void main() {
  group('GenerateAdCompletionToken', () {
    test('generates a non-empty token', () {
      expect(GenerateAdCompletionToken.call(), isNotEmpty);
    });

    test('generates distinct tokens across calls', () {
      expect(GenerateAdCompletionToken.call(), isNot(GenerateAdCompletionToken.call()));
    });
  });

  group('GrantRewardedUnlock', () {
    test('sets expiresAt to now plus the given duration', () {
      final unlock = GrantRewardedUnlock.call(
          moduleName: 'Analytics',
          merchantName: 'Acme Foods',
          duration: const Duration(minutes: 15),
          now: _now);

      expect(unlock.expiresAt, _now.add(const Duration(minutes: 15)));
    });
  });

  group('IsFeatureTemporarilyUnlocked', () {
    test('is true for an unexpired unlock matching module and merchant', () {
      expect(IsFeatureTemporarilyUnlocked.call([_unlock()], 'Analytics', 'Acme Foods', _now),
          isTrue);
    });

    test('is false once the unlock has expired', () {
      final expired = _unlock(expiresAt: _now.subtract(const Duration(minutes: 1)));

      expect(IsFeatureTemporarilyUnlocked.call([expired], 'Analytics', 'Acme Foods', _now),
          isFalse);
    });

    test('is false for a different merchant', () {
      expect(
          IsFeatureTemporarilyUnlocked.call([_unlock()], 'Analytics', 'Other Merchant', _now),
          isFalse);
    });
  });

  group('CheckModuleAccessWithRewards', () {
    test('allows access when the toggle itself already permits the route', () {
      expect(CheckModuleAccessWithRewards.call(const [], const [], '/settings', 'Acme Foods', _now),
          isTrue);
    });

    test('allows access via an active rewarded unlock when the toggle disables the route', () {
      final toggles = [
        FeatureModuleToggleEntity(
            moduleName: 'Analytics',
            routeName: '/analytics',
            isEnabled: false,
            updatedAt: _now)
      ];
      final unlocks = [_unlock(moduleName: 'Analytics', merchantName: 'Acme Foods')];

      expect(
          CheckModuleAccessWithRewards.call(toggles, unlocks, '/analytics', 'Acme Foods', _now),
          isTrue);
    });

    test('blocks access when the toggle disables the route and no unlock exists', () {
      final toggles = [
        FeatureModuleToggleEntity(
            moduleName: 'Analytics',
            routeName: '/analytics',
            isEnabled: false,
            updatedAt: _now)
      ];

      expect(
          CheckModuleAccessWithRewards.call(toggles, const [], '/analytics', 'Acme Foods', _now),
          isFalse);
    });
  });

  group('BuildRewardedUnlockNarrative', () {
    test('falls back when no unlocks are logged', () {
      expect(BuildRewardedUnlockNarrative.call(const []), contains('No rewarded promo unlocks'));
    });

    test('names the most recent unlock', () {
      final narrative = BuildRewardedUnlockNarrative.call([_unlock()]);

      expect(narrative, contains('Acme Foods'));
      expect(narrative, contains('Analytics'));
    });
  });
}
