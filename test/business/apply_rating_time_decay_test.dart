import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/apply_rating_time_decay.dart';

void main() {
  final now = DateTime(2026, 7, 1);

  test('no decay for a review rated today', () {
    expect(ApplyRatingTimeDecay.call(now, 5.0, now), 5.0);
  });

  test('decays roughly 5% per month', () {
    final oneMonthAgo = DateTime(2026, 6, 1);
    expect(ApplyRatingTimeDecay.call(oneMonthAgo, 5.0, now), closeTo(4.75, 0.01));
  });

  test('decays about 26-30% by 6 months old, matching the AC', () {
    final sixMonthsAgo = DateTime(2026, 1, 1);
    final decayed = ApplyRatingTimeDecay.call(sixMonthsAgo, 5.0, now);
    expect(decayed / 5.0, closeTo(0.74, 0.05));
  });
}
