import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/translate_with_fallback.dart';

void main() {
  const primary = {'greeting': 'Bonjour'};
  const fallback = {'greeting': 'Hello', 'farewell': 'Goodbye'};

  test('prefers the primary bundle when the key exists', () {
    expect(TranslateWithFallback.call('greeting', primary, fallback), 'Bonjour');
  });

  test('falls back to the secondary bundle when missing from primary', () {
    expect(TranslateWithFallback.call('farewell', primary, fallback), 'Goodbye');
  });

  test('falls back to the raw key when missing from both bundles', () {
    expect(TranslateWithFallback.call('unknown_key', primary, fallback), 'unknown_key');
  });
}
