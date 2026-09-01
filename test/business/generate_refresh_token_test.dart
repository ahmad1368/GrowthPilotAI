import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/generate_refresh_token.dart';

void main() {
  test('produces a 64-character hex string', () {
    final token = GenerateRefreshToken.call();
    expect(token.length, 64);
    expect(RegExp(r'^[0-9a-f]{64}$').hasMatch(token), true);
  });

  test('is random across calls', () {
    expect(GenerateRefreshToken.call(), isNot(GenerateRefreshToken.call()));
  });
}
