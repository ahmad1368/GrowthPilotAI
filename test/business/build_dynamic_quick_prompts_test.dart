import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_dynamic_quick_prompts.dart';

void main() {
  group('BuildDynamicQuickPrompts', () {
    test('caps the combined suggestions at 4 (AC: 3-4 Chips)', () {
      final prompts = BuildDynamicQuickPrompts.call(
        now: DateTime(2026, 4, 15),
        screenId: 'invoices',
        topCategory: 'Fuel',
        percentChangeVsLastMonth: 25,
        topCity: 'Surrey',
      );
      expect(prompts.length, lessThanOrEqualTo(4));
    });

    test('always includes the static GST/HST fallback', () {
      final prompts = BuildDynamicQuickPrompts.call(now: DateTime(2026, 8, 1), screenId: 'general');
      expect(prompts, contains('Total GST/HST collected this year'));
    });

    test('includes the seasonal prompt during the filing window', () {
      final prompts = BuildDynamicQuickPrompts.call(now: DateTime(2026, 4, 15), screenId: 'general');
      expect(prompts, contains('Analyze my 2025 tax deductions'));
    });

    test('never returns duplicate prompts', () {
      final prompts = BuildDynamicQuickPrompts.call(now: DateTime(2026, 8, 1), screenId: 'general');
      expect(prompts.toSet().length, prompts.length);
    });
  });
}
