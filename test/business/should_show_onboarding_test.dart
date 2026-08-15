import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/should_show_onboarding.dart';

void main() {
  group('ShouldShowOnboarding', () {
    test('shows the tour when it has never been completed or skipped', () {
      expect(ShouldShowOnboarding.call(false), isTrue);
    });

    test('hides the tour once completed or skipped, so it never repeats', () {
      expect(ShouldShowOnboarding.call(true), isFalse);
    });
  });
}
