import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/is_valid_document_file.dart';
import 'package:growth_pilot_ai/core/models/picked_document.dart';

void main() {
  group('IsValidDocumentFile', () {
    test('accepts a PDF within the size limit', () {
      const document = PickedDocument(fileName: 'report.pdf', sizeBytes: 1024);

      expect(IsValidDocumentFile.call(document), isTrue);
    });

    test('accepts a DOCX within the size limit', () {
      const document = PickedDocument(fileName: 'notes.docx', sizeBytes: 1024);

      expect(IsValidDocumentFile.call(document), isTrue);
    });

    test('rejects an unsupported extension', () {
      const document = PickedDocument(fileName: 'image.png', sizeBytes: 1024);

      expect(IsValidDocumentFile.call(document), isFalse);
    });

    test('rejects a file over the 20MB limit', () {
      const document = PickedDocument(
          fileName: 'huge.pdf', sizeBytes: IsValidDocumentFile.maxSizeBytes + 1);

      expect(IsValidDocumentFile.call(document), isFalse);
    });

    test('rejects an empty file', () {
      const document = PickedDocument(fileName: 'empty.pdf', sizeBytes: 0);

      expect(IsValidDocumentFile.call(document), isFalse);
    });
  });
}
