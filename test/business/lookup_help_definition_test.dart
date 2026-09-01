import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/lookup_help_definition.dart';

void main() {
  group('LookupHelpDefinition', () {
    final definitions = {'landed_cost': 'The total price of a product once it has arrived.'};

    test('returns the definition for a known termKey', () {
      expect(LookupHelpDefinition.call(definitions, 'landed_cost'),
          'The total price of a product once it has arrived.');
    });

    test('returns null for a termKey not in the dictionary, instead of throwing', () {
      expect(LookupHelpDefinition.call(definitions, 'not_a_real_term'), isNull);
    });

    test('returns null against an empty dictionary', () {
      expect(LookupHelpDefinition.call(const {}, 'landed_cost'), isNull);
    });
  });
}
