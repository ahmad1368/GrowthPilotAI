import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_document_chunk_ref.dart';

void main() {
  group('BuildDocumentChunkRef', () {
    test('joins documentId and chunkIndex with a colon', () {
      expect(BuildDocumentChunkRef.call('doc-42', 3), 'doc-42:3');
    });
  });
}
