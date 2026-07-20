import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/requires_bulk_confirmation.dart';

void main() {
  test('does not require confirmation at exactly the threshold', () {
    expect(RequiresBulkConfirmation.call(50), isFalse);
  });

  test('requires confirmation just above the threshold', () {
    expect(RequiresBulkConfirmation.call(51), isTrue);
  });

  test('does not require confirmation for a small selection', () {
    expect(RequiresBulkConfirmation.call(3), isFalse);
  });
}
