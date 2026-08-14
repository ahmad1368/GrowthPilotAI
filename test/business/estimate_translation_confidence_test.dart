import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/estimate_translation_confidence.dart';

void main() {
  test('computes the match ratio', () {
    expect(EstimateTranslationConfidence.call(3, 4), 0.75);
  });

  test('returns zero for an empty message', () {
    expect(EstimateTranslationConfidence.call(0, 0), 0);
  });

  test('returns 1.0 when every word matched', () {
    expect(EstimateTranslationConfidence.call(5, 5), 1.0);
  });
}
