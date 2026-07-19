import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/cap_recommendation_frequency.dart';

void main() {
  final now = DateTime(2026, 1, 15);

  test('allows sending when nothing has been sent this week', () {
    expect(
        CapRecommendationFrequency.canSend(recentSentAt: const [], now: now),
        isTrue);
  });

  test('allows sending a 2nd message when only 1 was sent this week', () {
    final canSend = CapRecommendationFrequency.canSend(
      recentSentAt: [now.subtract(const Duration(days: 2))],
      now: now,
    );

    expect(canSend, isTrue);
  });

  test('blocks a 3rd message once 2 were already sent this week', () {
    final canSend = CapRecommendationFrequency.canSend(
      recentSentAt: [
        now.subtract(const Duration(days: 1)),
        now.subtract(const Duration(days: 3)),
      ],
      now: now,
    );

    expect(canSend, isFalse);
  });

  test('ignores sends from outside the trailing 7-day window', () {
    final canSend = CapRecommendationFrequency.canSend(
      recentSentAt: [
        now.subtract(const Duration(days: 10)),
        now.subtract(const Duration(days: 20)),
      ],
      now: now,
    );

    expect(canSend, isTrue);
  });
}
