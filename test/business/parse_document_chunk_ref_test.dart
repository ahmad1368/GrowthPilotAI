import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_document_chunk_ref.dart';
import 'package:growth_pilot_ai/business/parse_document_chunk_ref.dart';

void main() {
  group('ParseDocumentChunkRef', () {
    test('round-trips through BuildDocumentChunkRef', () {
      final ref = ParseDocumentChunkRef.call(BuildDocumentChunkRef.call('doc-42', 3));

      expect(ref, isNotNull);
      expect(ref!.documentId, 'doc-42');
      expect(ref.chunkIndex, 3);
    });

    test('handles a documentId that itself contains a colon', () {
      final ref = ParseDocumentChunkRef.call('project:doc-42:3');

      expect(ref!.documentId, 'project:doc-42');
      expect(ref.chunkIndex, 3);
    });

    test('returns null for a non-document ref (e.g. a #198 Transaction embedding)', () {
      expect(ParseDocumentChunkRef.call('txn-123'), isNull);
    });

    test('returns null for a malformed ref with a non-numeric suffix', () {
      expect(ParseDocumentChunkRef.call('doc-42:abc'), isNull);
    });
  });
}
