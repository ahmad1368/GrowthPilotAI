/// Encodes a [DocumentChunkRef] into `EmbeddingEntity.sourceRefId`
/// (Issue #230) — `documentId:chunkIndex`.
class BuildDocumentChunkRef {
  static String call(String documentId, int chunkIndex) => '$documentId:$chunkIndex';
}
