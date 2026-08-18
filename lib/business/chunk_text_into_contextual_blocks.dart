/// "Chunking Strategy... Ensure Sentence-Level Splitting: Never cut a
/// chunk in the middle of a sentence" (Issue #227) — greedily packs
/// whole sentences into chunks up to [maxChunkChars]. Character count
/// stands in for the issue's token count (no tokenizer exists in this
/// repo; see PR notes) — a documented approximation, not a real LLM
/// tokenizer.
class ChunkTextIntoContextualBlocks {
  static const defaultMaxChunkChars = 3000;
  static final _sentenceBoundary = RegExp(r'(?<=[.!?])\s+');

  static List<String> call(String text, {int maxChunkChars = defaultMaxChunkChars}) {
    final sentences = text.split(_sentenceBoundary).where((s) => s.isNotEmpty);
    final chunks = <String>[];
    final buffer = StringBuffer();

    for (final sentence in sentences) {
      if (buffer.isNotEmpty && buffer.length + sentence.length + 1 > maxChunkChars) {
        chunks.add(buffer.toString().trim());
        buffer.clear();
      }
      if (buffer.isNotEmpty) buffer.write(' ');
      buffer.write(sentence);
    }
    if (buffer.isNotEmpty) chunks.add(buffer.toString().trim());
    return chunks;
  }
}
