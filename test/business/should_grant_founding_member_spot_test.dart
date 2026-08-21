import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/should_grant_founding_member_spot.dart';

void main() {
  group('ShouldGrantFoundingMemberSpot', () {
    test('grants a spot while under capacity', () {
      expect(ShouldGrantFoundingMemberSpot.call(claimedCount: 0, capacity: 100), isTrue);
      expect(ShouldGrantFoundingMemberSpot.call(claimedCount: 99, capacity: 100), isTrue);
    });

    test('does not grant the 101st spot (Issue #191 AC)', () {
      expect(ShouldGrantFoundingMemberSpot.call(claimedCount: 100, capacity: 100), isFalse);
      expect(ShouldGrantFoundingMemberSpot.call(claimedCount: 150, capacity: 100), isFalse);
    });
  });
}
