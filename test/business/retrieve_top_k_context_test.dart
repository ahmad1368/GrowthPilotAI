import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/retrieve_top_k_context.dart';
import 'package:growth_pilot_ai/core/data/entities/embedding_entity.dart';

EmbeddingEntity _fragment(String id, List<double> embedding) => EmbeddingEntity(
      sourceRefType: 'Transaction',
      sourceRefId: id,
      sourceText: 'Fragment $id',
      embedding: embedding,
    );

void main() {
  group('RetrieveTopKContext', () {
    test('ranks candidates by similarity to the query, most similar first', () {
      final candidates = [
        _fragment('a', [1.0, 0.0]), // orthogonal to query
        _fragment('b', [0.0, 1.0]), // identical to query
        _fragment('c', [0.0, 0.9]), // close to query
      ];

      final result = RetrieveTopKContext.call([0.0, 1.0], candidates, 3);

      expect(result.map((f) => f.sourceRefId), ['b', 'c', 'a']);
    });

    test('returns at most k results', () {
      final candidates = [_fragment('a', [1.0, 0.0]), _fragment('b', [0.0, 1.0])];
      final result = RetrieveTopKContext.call([0.0, 1.0], candidates, 1);
      expect(result.length, 1);
    });
  });
}
