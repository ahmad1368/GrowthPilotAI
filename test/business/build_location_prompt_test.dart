import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_location_prompt.dart';

void main() {
  group('BuildLocationPrompt', () {
    test('null when there is no dominant city yet', () {
      expect(BuildLocationPrompt.call(null), isNull);
    });

    test('phrases the prompt around the given city', () {
      expect(BuildLocationPrompt.call('Surrey'), 'Analyze my spending in Surrey');
    });
  });
}
