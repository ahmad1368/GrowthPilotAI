import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/chunk_text_into_contextual_blocks.dart';

void main() {
  group('ChunkTextIntoContextualBlocks', () {
    test('keeps short text as a single chunk', () {
      final chunks = ChunkTextIntoContextualBlocks.call('One sentence. Another sentence.');

      expect(chunks.length, 1);
    });

    test('splits into multiple chunks without cutting a sentence in half', () {
      const sentence = 'This is a business requirement sentence. ';
      final text = sentence * 200; // well over the default chunk size

      final chunks = ChunkTextIntoContextualBlocks.call(text, maxChunkChars: 500);

      expect(chunks.length, greaterThan(1));
      for (final chunk in chunks) {
        expect(chunk.trim().endsWith('.'), isTrue);
      }
    });

    test('empty text produces no chunks', () {
      expect(ChunkTextIntoContextualBlocks.call(''), isEmpty);
    });
  });
}
