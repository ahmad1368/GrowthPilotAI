import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/resolve_postal_code_to_coordinates.dart';

void main() {
  test('resolves a known Coquitlam prefix', () {
    final coords = ResolvePostalCodeToCoordinates.call('V3J 1A1');
    expect(coords, isNotNull);
    expect(coords!.lat, closeTo(49.27, 0.1));
  });

  test('is case-insensitive and ignores whitespace', () {
    final coords = ResolvePostalCodeToCoordinates.call(' v3j 1a1 ');
    expect(coords, isNotNull);
  });

  test('returns null for an unrecognized prefix', () {
    expect(ResolvePostalCodeToCoordinates.call('K1A 0B1'), isNull);
  });

  test('returns null for input shorter than a prefix', () {
    expect(ResolvePostalCodeToCoordinates.call('V3'), isNull);
  });
}
