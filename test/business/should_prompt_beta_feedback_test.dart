import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/should_prompt_beta_feedback.dart';

void main() {
  group('ShouldPromptBetaFeedback', () {
    test('prompts after the 3rd invoice scan (Issue #191 AC)', () {
      expect(ShouldPromptBetaFeedback.call(invoiceScanCount: 3, marketplaceMatchCount: 0), isTrue);
    });

    test('prompts after the 1st marketplace match (Issue #191 AC)', () {
      expect(ShouldPromptBetaFeedback.call(invoiceScanCount: 0, marketplaceMatchCount: 1), isTrue);
    });

    test('does not prompt before either threshold is reached', () {
      expect(ShouldPromptBetaFeedback.call(invoiceScanCount: 2, marketplaceMatchCount: 0), isFalse);
    });
  });
}
