import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/generate_access_token.dart';

void main() {
  test('produces a three-part dot-delimited JWT-shaped token', () {
    final token = GenerateAccessToken.call('device-1', DateTime(2026, 1, 1));
    expect(token.split('.').length, 3);
  });

  test('is deterministic for identical inputs', () {
    final expiry = DateTime(2026, 1, 1);
    expect(GenerateAccessToken.call('device-1', expiry), GenerateAccessToken.call('device-1', expiry));
  });

  test('differs for different subjects', () {
    final expiry = DateTime(2026, 1, 1);
    expect(GenerateAccessToken.call('device-1', expiry), isNot(GenerateAccessToken.call('device-2', expiry)));
  });
}
