import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/sanitize_document_text.dart';

void main() {
  group('SanitizeDocumentText', () {
    const raw = 'Step 1: Submit form\n\n\nPage 2 of 5\nConfidential — internal use only.\n\nStep 2: Approve';

    test('keeps the original raw text untouched for the Diff View', () {
      final result = SanitizeDocumentText.call(raw);

      expect(result.rawText, raw);
    });

    test('strips page numbers and legal boilerplate by default', () {
      final result = SanitizeDocumentText.call(raw);

      expect(result.sanitizedText, isNot(contains('Page 2 of 5')));
      expect(result.sanitizedText, isNot(contains('Confidential')));
      expect(result.sanitizedText, contains('Step 1'));
      expect(result.sanitizedText, contains('Step 2'));
    });

    test('keeps boilerplate lines when stripBoilerplate is false', () {
      final result = SanitizeDocumentText.call(raw, stripBoilerplate: false);

      expect(result.sanitizedText, contains('Confidential'));
    });
  });
}
