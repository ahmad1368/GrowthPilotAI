import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/utils/oauth_state.dart';

void main() {
  group('OAuthState.generate', () {
    test('produces a non-empty, URL-safe value', () {
      final state = OAuthState.generate();
      expect(state, isNotEmpty);
      expect(state, matches(RegExp(r'^[A-Za-z0-9_-]+$')));
    });

    test('produces a different value on each call', () {
      expect(OAuthState.generate(), isNot(OAuthState.generate()));
    });
  });

  group('OAuthState.verify', () {
    test('accepts an exact match', () {
      final s = OAuthState.generate();
      expect(OAuthState.verify(s, s), isTrue);
    });

    test('rejects a mismatch', () {
      expect(OAuthState.verify('abc', 'xyz'), isFalse);
    });

    test('rejects an empty expected state (fail closed)', () {
      expect(OAuthState.verify('', ''), isFalse);
    });
  });
}
