import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_rag_prompt_context.dart';
import 'package:growth_pilot_ai/core/data/entities/embedding_entity.dart';

void main() {
  group('BuildRagPromptContext', () {
    test('joins fragment text into a single "Context: ..." prefix', () {
      final fragments = [
        EmbeddingEntity(
            sourceRefType: 'Transaction',
            sourceRefId: '1',
            sourceText: 'Invoice A: \$500 from ABC Logistics, Surrey',
            embedding: const [0.1]),
      ];

      expect(BuildRagPromptContext.call(fragments),
          'Context: Invoice A: \$500 from ABC Logistics, Surrey.');
    });

    test('returns an empty string when there is no retrieved context', () {
      expect(BuildRagPromptContext.call(const []), '');
    });
  });
}
