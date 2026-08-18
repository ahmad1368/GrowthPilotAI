import 'package:get_it/get_it.dart';
import 'package:growth_pilot_ai/business/build_document_chunk_ref.dart';
import 'package:growth_pilot_ai/core/data/entities/embedding_entity.dart';
import 'package:growth_pilot_ai/core/data/repositories/embedding_repository.dart';
import 'package:growth_pilot_ai/core/interfaces/embedding_service.dart';

/// "Indexing Strategy: store the sanitized_text in chunks... each
/// vector must include metadata" (Issue #230) — reuses #198's
/// [EmbeddingEntity]/[EmbeddingRepository] "Vector DB" for document
/// chunks too, distinguished by [sourceRefType].
class IndexDocumentChunks {
  static const sourceRefType = 'DocumentChunk';

  static Future<void> call(String documentId, List<String> chunks) async {
    final embeddingService = GetIt.I<EmbeddingService>();
    final repository = GetIt.I<EmbeddingRepository>();

    for (var i = 0; i < chunks.length; i++) {
      final embedded = await embeddingService.embed(chunks[i]);
      if (!embedded.success || embedded.data == null) continue;

      repository.upsert(EmbeddingEntity(
        sourceRefType: sourceRefType,
        sourceRefId: BuildDocumentChunkRef.call(documentId, i),
        sourceText: chunks[i],
        embedding: embedded.data!,
      ));
    }
  }
}
