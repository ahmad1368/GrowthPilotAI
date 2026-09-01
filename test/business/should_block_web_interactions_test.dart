import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/should_block_web_interactions.dart';

void main() {
  group('ShouldBlockWebInteractions', () {
    test('blocks on web when offline', () {
      expect(ShouldBlockWebInteractions.call(isWeb: true, isOnline: false), isTrue);
    });

    test('does not block on web when online', () {
      expect(ShouldBlockWebInteractions.call(isWeb: true, isOnline: true), isFalse);
    });

    test('never blocks on mobile, even when offline', () {
      expect(ShouldBlockWebInteractions.call(isWeb: false, isOnline: false), isFalse);
    });
  });
}
