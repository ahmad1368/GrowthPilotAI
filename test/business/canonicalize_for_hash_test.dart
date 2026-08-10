import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/canonicalize_for_hash.dart';

void main() {
  test('a plain string passes through unchanged', () {
    expect(CanonicalizeForHash.call('hello'), 'hello');
  });

  // The falsifiable check the issue's review demanded: semantically
  // identical maps built in a different key order must canonicalize
  // (and later hash) identically.
  test('map key order does not affect the canonical form', () {
    final a = CanonicalizeForHash.call({'title': 'A', 'providerId': 'u1'});
    final b = CanonicalizeForHash.call({'providerId': 'u1', 'title': 'A'});
    expect(a, b);
  });

  test('nested maps and lists are canonicalized recursively', () {
    final a = CanonicalizeForHash.call({
      'tags': ['x', 'y'],
      'meta': {'b': 2, 'a': 1},
    });
    final b = CanonicalizeForHash.call({
      'meta': {'a': 1, 'b': 2},
      'tags': ['x', 'y'],
    });
    expect(a, b);
  });

  test('different values produce a different canonical form', () {
    final a = CanonicalizeForHash.call({'a': 1});
    final b = CanonicalizeForHash.call({'a': 2});
    expect(a, isNot(b));
  });
}
