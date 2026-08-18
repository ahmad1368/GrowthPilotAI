import 'package:get_it/get_it.dart';
import 'package:growth_pilot_ai/business/index_document_chunks.dart';
import 'package:growth_pilot_ai/business/parse_document_chunk_ref.dart';
import 'package:growth_pilot_ai/business/retrieve_top_k_context.dart';
import 'package:growth_pilot_ai/core/data/repositories/embedding_repository.dart';
import 'package:growth_pilot_ai/core/interfaces/embedding_service.dart';
import 'package:growth_pilot_ai/core/models/document_search_result.dart';

/// "Semantic Search" across indexed documents (Issue #230's "Hybrid
/// Search") — embeds the query, then reuses #198's [RetrieveTopKContext]
/// brute-force cosine search (this repo's honest substitute for
/// ChromaDB/Pinecone; see PR notes) restricted to [IndexDocumentChunks]
/// rows, optionally further restricted to one [documentId].
class SearchDocumentChunks {
  static const defaultTopK = 5;

  static Future<List<DocumentSearchResult>> call(
    String query, {
    String? documentId,
    int topK = defaultTopK,
  }) async {
    final embedded = await GetIt.I<EmbeddingService>().embed(query);
    if (!embedded.success || embedded.data == null) return const [];

    final candidates = GetIt.I<EmbeddingRepository>()
        .getAll()
        .where((e) => e.sourceRefType == IndexDocumentChunks.sourceRefType)
        .where((e) => documentId == null || e.sourceRefId.startsWith('$documentId:'))
        .toList();

    final topMatches = RetrieveTopKContext.call(embedded.data!, candidates, topK);
    return [
      for (final match in topMatches)
        if (ParseDocumentChunkRef.call(match.sourceRefId) case final ref?)
          DocumentSearchResult(
              sourceText: match.sourceText, documentId: ref.documentId, chunkIndex: ref.chunkIndex),
    ];
  }
}
