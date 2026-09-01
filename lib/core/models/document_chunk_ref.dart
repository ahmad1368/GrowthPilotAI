import 'package:flutter/foundation.dart';

/// Which document + chunk one [EmbeddingEntity] row came from (Issue
/// #230's own "project_id, document_id" metadata) — this app has no
/// project/page concept, so [chunkIndex] stands in for the issue's
/// `page_number` (see PR notes).
@immutable
class DocumentChunkRef {
  final String documentId;
  final int chunkIndex;

  const DocumentChunkRef({required this.documentId, required this.chunkIndex});
}
