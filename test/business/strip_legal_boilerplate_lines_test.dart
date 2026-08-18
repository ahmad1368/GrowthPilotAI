import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/strip_legal_boilerplate_lines.dart';

void main() {
  group('StripLegalBoilerplateLines', () {
    test('removes a confidentiality notice line', () {
      final result =
          StripLegalBoilerplateLines.call('Step 1: Submit form\nThis document is confidential.\nStep 2: Review');

      expect(result, isNot(contains('confidential')));
      expect(result, contains('Step 1'));
      expect(result, contains('Step 2'));
    });

    test('removes an "all rights reserved" footer', () {
      final result = StripLegalBoilerplateLines.call('Body text\n© 2026 Acme Corp. All Rights Reserved.');

      expect(result, 'Body text');
    });

    test('leaves unrelated lines untouched', () {
      final result = StripLegalBoilerplateLines.call('Normal business text with no legal markers.');

      expect(result, 'Normal business text with no legal markers.');
    });
  });
}
