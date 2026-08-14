import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/estimate_translation_resource_cost.dart';

void main() {
  test('scales linearly with word count', () {
    final cost = EstimateTranslationResourceCost.call(10);
    expect(cost.processingMicroseconds, 500);
    expect(cost.estimatedMemoryBytes, 640);
  });

  test('is zero for an empty message', () {
    final cost = EstimateTranslationResourceCost.call(0);
    expect(cost.processingMicroseconds, 0);
    expect(cost.estimatedMemoryBytes, 0);
  });
}
