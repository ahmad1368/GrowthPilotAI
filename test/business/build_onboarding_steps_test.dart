import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_onboarding_steps.dart';

void main() {
  group('BuildOnboardingSteps', () {
    test('web steps focus on Desktop-only features (AC: Platform Specificity)', () {
      final steps = BuildOnboardingSteps.call(isWeb: true);

      expect(steps, isNotEmpty);
      expect(steps.any((s) => s.title.contains('Bulk Import')), isTrue);
      expect(steps.any((s) => s.title.contains('Scan Invoices')), isFalse);
    });

    test('mobile steps focus on Field features (AC: Platform Specificity)', () {
      final steps = BuildOnboardingSteps.call(isWeb: false);

      expect(steps, isNotEmpty);
      expect(steps.any((s) => s.title.contains('Scan Invoices')), isTrue);
      expect(steps.any((s) => s.title.contains('Bulk Import')), isFalse);
    });
  });
}
