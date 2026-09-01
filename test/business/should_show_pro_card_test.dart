import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/should_show_pro_card.dart';

void main() {
  final now = DateTime.utc(2027, 6, 15);

  test('shows a card when none has ever been shown', () {
    expect(ShouldShowProCard.call(null, now), isTrue);
  });

  test('does not show a card within the weekly cooldown', () {
    final lastShown = now.subtract(const Duration(days: 3));
    expect(ShouldShowProCard.call(lastShown, now), isFalse);
  });

  test('shows a card once a full week has passed', () {
    final lastShown = now.subtract(const Duration(days: 7));
    expect(ShouldShowProCard.call(lastShown, now), isTrue);
  });
}
