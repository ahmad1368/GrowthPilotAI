import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_quick_prompts.dart';

void main() {
  group('BuildQuickPrompts', () {
    test('returns invoice-specific prompts for the invoices screen', () {
      expect(BuildQuickPrompts.call('invoices'), contains("Summarize this month's taxes"));
    });

    test('returns marketplace-specific prompts for the marketplace screen', () {
      expect(BuildQuickPrompts.call('marketplace'), contains('How are my listings performing?'));
    });

    test('falls back to general prompts for an unrecognized screen', () {
      expect(BuildQuickPrompts.call('some-unknown-screen'), isNotEmpty);
    });
  });
}
