import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/models/hash_pepper.dart';

void main() {
  test('accepts a non-empty value', () {
    expect(HashPepper('some-secret').value, 'some-secret');
  });

  test('throws instead of silently accepting an empty value', () {
    expect(() => HashPepper(''), throwsStateError);
  });
}
