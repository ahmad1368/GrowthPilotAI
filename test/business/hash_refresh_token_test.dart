import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/hash_refresh_token.dart';

void main() {
  test('produces a 64-character hex SHA-256 digest', () {
    final hash = HashRefreshToken.call('some-raw-token');
    expect(hash.length, 64);
  });

  test('is deterministic', () {
    expect(HashRefreshToken.call('token-a'), HashRefreshToken.call('token-a'));
  });

  test('differs for different tokens', () {
    expect(HashRefreshToken.call('token-a'), isNot(HashRefreshToken.call('token-b')));
  });
}
