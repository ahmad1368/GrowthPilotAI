import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/needs_legal_reacceptance.dart';

void main() {
  group('NeedsLegalReacceptance', () {
    test('true when nothing has been accepted yet', () {
      expect(NeedsLegalReacceptance.call(null, 'v1.0.0'), isTrue);
    });

    test('false when the accepted version matches current', () {
      expect(NeedsLegalReacceptance.call('v1.0.0', 'v1.0.0'), isFalse);
    });

    test('true when the accepted version is outdated', () {
      expect(NeedsLegalReacceptance.call('v1.0.0', 'v2.0.0'), isTrue);
    });
  });
}
