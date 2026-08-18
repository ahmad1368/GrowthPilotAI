import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/models/picked_document.dart';

void main() {
  group('PickedDocument.extension', () {
    test('lowercases the extension', () {
      const document = PickedDocument(fileName: 'Report.PDF', sizeBytes: 1);

      expect(document.extension, 'pdf');
    });

    test('empty string when there is no extension', () {
      const document = PickedDocument(fileName: 'README', sizeBytes: 1);

      expect(document.extension, '');
    });
  });
}
