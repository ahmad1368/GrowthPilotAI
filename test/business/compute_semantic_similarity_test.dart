import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_semantic_similarity.dart';

void main() {
  test('identical text scores a perfect match', () {
    expect(ComputeSemanticSimilarity.call('brake repair automotive', 'brake repair automotive'), 1.0);
  });

  test('completely unrelated text scores zero', () {
    expect(ComputeSemanticSimilarity.call('brake repair', 'wedding photography'), 0.0);
  });

  test('partial word overlap scores between 0 and 1', () {
    final score = ComputeSemanticSimilarity.call(
        'need brake repair for my truck', 'automotive brake repair services');
    expect(score, greaterThan(0));
    expect(score, lessThan(1));
  });

  test('is case-insensitive', () {
    expect(ComputeSemanticSimilarity.call('Brake Repair', 'brake repair'), 1.0);
  });

  test('returns zero for empty input', () {
    expect(ComputeSemanticSimilarity.call('', 'anything'), 0.0);
  });
}
