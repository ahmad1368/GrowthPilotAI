import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_top_category_prompt.dart';

void main() {
  group('BuildTopCategoryPrompt', () {
    test('null when there is no top category yet', () {
      expect(BuildTopCategoryPrompt.call(topCategory: null), isNull);
    });

    test('phrases as an anomaly when the increase is 20% or more', () {
      final result = BuildTopCategoryPrompt.call(topCategory: 'Dining', percentChangeVsLastMonth: 25);
      expect(result, 'Why is my Dining spending up?');
    });

    test('phrases as a general question when there is no anomaly signal', () {
      final result = BuildTopCategoryPrompt.call(topCategory: 'Fuel');
      expect(result, 'Why did I spend more on Fuel?');
    });
  });
}
