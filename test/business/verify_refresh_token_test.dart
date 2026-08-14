import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/hash_refresh_token.dart';
import 'package:growth_pilot_ai/business/verify_refresh_token.dart';

void main() {
  test('verifies a matching raw token against its hash', () {
    final hash = HashRefreshToken.call('correct-token');
    expect(VerifyRefreshToken.call('correct-token', hash), true);
  });

  test('rejects a non-matching token', () {
    final hash = HashRefreshToken.call('correct-token');
    expect(VerifyRefreshToken.call('wrong-token', hash), false);
  });
}
