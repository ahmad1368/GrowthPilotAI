import 'package:flutter/foundation.dart';

/// One "Hybrid Search" hit (Issue #230) — [documentId]/[chunkIndex]
/// back the AC's "Citations" (e.g. "Found on Page 12 of Document A");
/// [chunkIndex] stands in for a real page number (see PR notes).
@immutable
class DocumentSearchResult {
  final String sourceText;
  final String documentId;
  final int chunkIndex;

  const DocumentSearchResult({
    required this.sourceText,
    required this.documentId,
    required this.chunkIndex,
  });
}
