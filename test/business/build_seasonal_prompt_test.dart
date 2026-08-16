import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_seasonal_prompt.dart';

void main() {
  group('BuildSeasonalPrompt', () {
    test('suggests a tax-deduction prompt during the Jan-Apr filing window', () {
      expect(BuildSeasonalPrompt.call(DateTime(2026, 4, 15)), 'Analyze my 2025 tax deductions');
    });

    test('returns null outside the filing window', () {
      expect(BuildSeasonalPrompt.call(DateTime(2026, 8, 1)), isNull);
    });
  });
}
