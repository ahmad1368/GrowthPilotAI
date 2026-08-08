import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/create_auth_session.dart';
import 'package:growth_pilot_ai/business/rotate_auth_session.dart';

void main() {
  final now = DateTime(2026, 1, 1);

  test('rotates an active, unexpired session into a new token pair', () {
    final original = CreateAuthSession.call('This Device', now).session;
    final rotated = RotateAuthSession.call(original, now.add(const Duration(days: 1)));
    expect(rotated, isNotNull);
    expect(rotated!.rawRefreshToken, isNot(''));
  });

  test('refuses to rotate a revoked session', () {
    final original = CreateAuthSession.call('This Device', now).session..isRevoked = true;
    expect(RotateAuthSession.call(original, now), isNull);
  });

  test('refuses to rotate an expired session', () {
    final original = CreateAuthSession.call('This Device', now).session;
    final farFuture = now.add(const Duration(days: 31));
    expect(RotateAuthSession.call(original, farFuture), isNull);
  });
}
