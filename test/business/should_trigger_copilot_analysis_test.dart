import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/should_trigger_copilot_analysis.dart';

void main() {
  test('triggers analysis when the user is active', () {
    expect(ShouldTriggerCopilotAnalysis.call(isUserActiveInChat: true), isTrue);
  });

  test('skips analysis to save API tokens when the user is inactive', () {
    expect(ShouldTriggerCopilotAnalysis.call(isUserActiveInChat: false), isFalse);
  });
}
