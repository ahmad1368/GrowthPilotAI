import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/is_delete_confirmation_valid.dart';

void main() {
  group('IsDeleteConfirmationValid (Issue #189)', () {
    test('accepts exactly "DELETE"', () {
      expect(IsDeleteConfirmationValid.call('DELETE'), isTrue);
    });

    test('trims surrounding whitespace', () {
      expect(IsDeleteConfirmationValid.call('  DELETE  '), isTrue);
    });

    test('rejects wrong case', () {
      expect(IsDeleteConfirmationValid.call('delete'), isFalse);
    });

    test('rejects empty input', () {
      expect(IsDeleteConfirmationValid.call(''), isFalse);
    });

    test('rejects a near-miss', () {
      expect(IsDeleteConfirmationValid.call('DELET'), isFalse);
    });
  });
}
