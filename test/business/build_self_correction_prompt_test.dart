import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_self_correction_prompt.dart';

void main() {
  group('BuildSelfCorrectionPrompt', () {
    test('names the correct record when one exists', () {
      final prompt = BuildSelfCorrectionPrompt.call(500.0, 450.0);
      expect(prompt, 'Error: You mentioned \$500.00 but the record shows \$450.00. Please correct your summary.');
    });

    test('says no record was found when there is no correction available', () {
      final prompt = BuildSelfCorrectionPrompt.call(5000.0, null);
      expect(prompt, contains('no matching record was found'));
    });
  });
}
