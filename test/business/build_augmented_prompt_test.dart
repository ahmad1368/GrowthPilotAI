import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_augmented_prompt.dart';

void main() {
  group('BuildAugmentedPrompt', () {
    test('wraps the context table and question in the system instruction', () {
      final prompt = BuildAugmentedPrompt.call(
        contextTable: '| Date | Merchant |\n|---|---|\n| 2026-03-05 | ABC Logistics |',
        userQuery: 'What was my last logistics spend?',
      );

      expect(prompt, contains("If the data is not present, say you don't know."));
      expect(prompt, contains('[LOCAL DATA CONTEXT]'));
      expect(prompt, contains('ABC Logistics'));
      expect(prompt, contains('[USER QUESTION]'));
      expect(prompt, contains('What was my last logistics spend?'));
      expect(prompt, contains('Use CAD currency.'));
    });
  });
}
