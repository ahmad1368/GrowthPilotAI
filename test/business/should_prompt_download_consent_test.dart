import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/should_prompt_download_consent.dart';

void main() {
  group('ShouldPromptDownloadConsent', () {
    test('prompts when the user has not consented yet', () {
      expect(ShouldPromptDownloadConsent.call(false), isTrue);
    });

    test('does not re-prompt once the user has already consented', () {
      expect(ShouldPromptDownloadConsent.call(true), isFalse);
    });
  });
}
