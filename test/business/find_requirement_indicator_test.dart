import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/find_requirement_indicator.dart';

void main() {
  group('FindRequirementIndicator', () {
    test('finds "shall" in a requirement sentence', () {
      expect(FindRequirementIndicator.call('The system shall provide reports.'), 'shall');
    });

    test('finds "must" case-insensitively', () {
      expect(FindRequirementIndicator.call('Users MUST authenticate first.'), 'must');
    });

    test('returns null for a sentence with no modal indicator', () {
      expect(FindRequirementIndicator.call('This is just a description.'), isNull);
    });
  });
}
