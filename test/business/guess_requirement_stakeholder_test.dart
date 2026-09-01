import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/guess_requirement_stakeholder.dart';

void main() {
  group('GuessRequirementStakeholder', () {
    test('detects a known stakeholder keyword', () {
      expect(GuessRequirementStakeholder.call('The manager shall approve all requests.'), 'Manager');
    });

    test('is case-insensitive', () {
      expect(GuessRequirementStakeholder.call('The CUSTOMER must confirm the order.'), 'Customer');
    });

    test('defaults to Unassigned when no keyword matches', () {
      expect(GuessRequirementStakeholder.call('The system shall log every event.'), 'Unassigned');
    });
  });
}
