import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/apply_k_anonymity.dart';

void main() {
  test('keeps groups at or above k and reports zero suppressed', () {
    final data = ['a', 'a', 'a', 'a', 'a'];
    final result = ApplyKAnonymity.call<String>(data, (s) => s, k: 5);
    expect(result.data, data);
    expect(result.suppressedCount, 0);
  });

  // The issue's own AC: an individual's unique combination of traits must
  // not survive in a group smaller than k.
  test('suppresses a uniquely-identifying group smaller than k', () {
    final data = ['common', 'common', 'common', 'common', 'common', 'unique'];
    final result = ApplyKAnonymity.call<String>(data, (s) => s, k: 5);
    expect(result.data, isNot(contains('unique')));
    expect(result.suppressedCount, 1);
  });

  test('mixed groups: only undersized groups are dropped', () {
    final data = ['a', 'a', 'a', 'b', 'b'];
    final result = ApplyKAnonymity.call<String>(data, (s) => s, k: 3);
    expect(result.data, ['a', 'a', 'a']);
    expect(result.suppressedCount, 2);
  });

  test('an empty input produces no data and no suppression', () {
    final result = ApplyKAnonymity.call<String>(<String>[], (s) => s);
    expect(result.data, isEmpty);
    expect(result.suppressedCount, 0);
  });
}
