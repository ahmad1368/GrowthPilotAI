import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/data/datasources/mock_social_auth_service.dart';

void main() {
  late MockSocialAuthService auth;

  setUp(() => auth = MockSocialAuthService());

  group('Google sign-in', () {
    test('grants a user and an in-memory ID token', () async {
      final response = await auth.signInWithGoogle();
      expect(response.success, isTrue);
      expect(response.data?.email, 'user@example.com');
      expect(auth.currentUser, isNotNull);
      expect(auth.idToken, isNotNull);
    });
  });

  group('Phone verification', () {
    test('rejects an empty phone number', () async {
      final response = await auth.startPhoneVerification('  ');
      expect(response.success, isFalse);
      expect(response.statusCode, 400);
    });

    test('returns a verificationId for a valid number', () async {
      final response = await auth.startPhoneVerification('+15551234567');
      expect(response.success, isTrue);
      expect(response.data, isNotEmpty);
    });

    test('confirms the correct SMS code', () async {
      final response = await auth.confirmPhoneCode(
          'vid', MockSocialAuthService.validSmsCode);
      expect(response.success, isTrue);
      expect(auth.currentUser?.phoneNumber, isNotNull);
    });

    test('rejects an incorrect SMS code with 401', () async {
      final response = await auth.confirmPhoneCode('vid', '000000');
      expect(response.success, isFalse);
      expect(response.statusCode, 401);
      expect(auth.currentUser, isNull);
    });
  });

  group('Sign out', () {
    test('clears the session token and user', () async {
      await auth.signInWithGoogle();
      await auth.signOut();
      expect(auth.currentUser, isNull);
      expect(auth.idToken, isNull);
    });
  });
}
