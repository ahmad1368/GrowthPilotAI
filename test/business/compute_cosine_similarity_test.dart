import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_cosine_similarity.dart';

void main() {
  test('identical vectors are perfectly similar', () {
    expect(ComputeCosineSimilarity.call([1, 2, 3], [1, 2, 3]), closeTo(1.0, 1e-9));
  });

  test('a scaled copy of the same vector is still perfectly similar', () {
    expect(ComputeCosineSimilarity.call([1, 2, 3], [2, 4, 6]), closeTo(1.0, 1e-9));
  });

  test('orthogonal vectors have zero similarity', () {
    expect(ComputeCosineSimilarity.call([1, 0], [0, 1]), closeTo(0.0, 1e-9));
  });

  test('opposite vectors are maximally dissimilar', () {
    expect(ComputeCosineSimilarity.call([1, 0], [-1, 0]), closeTo(-1.0, 1e-9));
  });

  test('a zero vector yields zero similarity rather than dividing by zero', () {
    expect(ComputeCosineSimilarity.call([0, 0], [1, 2]), 0);
  });
}
