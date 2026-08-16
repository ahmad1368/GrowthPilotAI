import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/prioritize_prompts_by_click_history.dart';
import 'package:growth_pilot_ai/core/data/entities/prompt_click_entity.dart';

PromptClickEntity _click(String prompt, int count) =>
    PromptClickEntity(promptText: prompt, clickCount: count, lastClickedAt: DateTime(2026, 1, 1));

void main() {
  group('PrioritizePromptsByClickHistory', () {
    test('puts the most-clicked prompt first', () {
      final result = PrioritizePromptsByClickHistory.call(
        ['A', 'B', 'C'],
        [_click('C', 5), _click('A', 1)],
      );
      expect(result.first, 'C');
    });

    test('a prompt with no click history is treated as zero clicks, not an error', () {
      final result = PrioritizePromptsByClickHistory.call(['A', 'B'], [_click('B', 3)]);
      expect(result, ['B', 'A']);
    });

    test('empty click history leaves the original order unchanged', () {
      final result = PrioritizePromptsByClickHistory.call(['A', 'B', 'C'], const []);
      expect(result, ['A', 'B', 'C']);
    });
  });
}
