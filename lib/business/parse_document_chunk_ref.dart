import 'package:growth_pilot_ai/core/models/document_chunk_ref.dart';

/// Reverses [BuildDocumentChunkRef] — returns null for a malformed or
/// non-document `sourceRefId` (e.g. a Transaction embedding from #198
/// sharing the same [EmbeddingEntity] table).
class ParseDocumentChunkRef {
  static DocumentChunkRef? call(String sourceRefId) {
    final separator = sourceRefId.lastIndexOf(':');
    if (separator <= 0 || separator == sourceRefId.length - 1) return null;

    final chunkIndex = int.tryParse(sourceRefId.substring(separator + 1));
    if (chunkIndex == null) return null;

    return DocumentChunkRef(documentId: sourceRefId.substring(0, separator), chunkIndex: chunkIndex);
  }
}
