import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/generate_deterministic_hash.dart';
import 'package:growth_pilot_ai/core/models/hash_pepper.dart';

void main() {
  final pepper = HashPepper('test-pepper');

  test('hashing is deterministic for the same input', () {
    final a = GenerateDeterministicHash.call('user_123', pepper);
    final b = GenerateDeterministicHash.call('user_123', pepper);
    expect(a, b);
  });

  test('map key order does not affect the resulting hash', () {
    final a = GenerateDeterministicHash.call({'a': 1, 'b': 2}, pepper);
    final b = GenerateDeterministicHash.call({'b': 2, 'a': 1}, pepper);
    expect(a, b);
  });

  test('a one-character change in input produces a completely different hash', () {
    final a = GenerateDeterministicHash.call('user_123', pepper);
    final b = GenerateDeterministicHash.call('user_124', pepper);
    expect(a, isNot(b));
  });

  test('a different pepper produces a different hash for the same input', () {
    final a = GenerateDeterministicHash.call('user_123', pepper);
    final b = GenerateDeterministicHash.call('user_123', HashPepper('other-pepper'));
    expect(a, isNot(b));
  });

  test('output is a 64-character hex string (SHA-256 digest)', () {
    final hash = GenerateDeterministicHash.call('user_123', pepper);
    expect(hash, matches(RegExp(r'^[0-9a-f]{64}$')));
  });
}
