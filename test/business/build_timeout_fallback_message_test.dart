import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_timeout_fallback_message.dart';

void main() {
  group('BuildTimeoutFallbackMessage', () {
    test('matches the issue\'s own fallback copy', () {
      expect(BuildTimeoutFallbackMessage.call(),
          'The AI is taking longer than usual. Would you like to continue waiting or try a simpler question?');
    });
  });
}
