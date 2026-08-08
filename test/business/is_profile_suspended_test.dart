import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/is_profile_suspended.dart';
import 'package:growth_pilot_ai/business/register_strike.dart';
import 'package:growth_pilot_ai/core/enum/moderation_reason.dart';

void main() {
  final now = DateTime(2026, 1, 1);

  test('not suspended below the threshold', () {
    final strikes = List.generate(
        2, (_) => RegisterStrike.call(targetId: 'v1', reason: ModerationReason.spam, now: now));
    expect(IsProfileSuspended.call(strikes, 'v1', now), isFalse);
  });

  test('suspended once the threshold is reached', () {
    final strikes = List.generate(
        3, (_) => RegisterStrike.call(targetId: 'v1', reason: ModerationReason.spam, now: now));
    expect(IsProfileSuspended.call(strikes, 'v1', now), isTrue);
  });

  test('expired non-critical strikes no longer count toward suspension', () {
    final expired = RegisterStrike.call(targetId: 'v1', reason: ModerationReason.spam, now: now);
    final farFuture = now.add(const Duration(days: 91));
    final strikes = List.filled(3, expired);
    expect(IsProfileSuspended.call(strikes, 'v1', farFuture), isFalse);
  });

  test('a critical strike counts even far in the future', () {
    final critical = RegisterStrike.call(
        targetId: 'v1', reason: ModerationReason.fraud, now: now, isCritical: true);
    final strikes = List.filled(3, critical);
    expect(IsProfileSuspended.call(strikes, 'v1', now.add(const Duration(days: 365))), isTrue);
  });
}
