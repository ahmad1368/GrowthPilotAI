import 'package:growth_pilot_ai/core/interfaces/social_auth_service.dart';
import 'package:growth_pilot_ai/core/models/auth_user.dart';
import 'package:growth_pilot_ai/core/models/omni_response.dart';
import 'package:growth_pilot_ai/core/utils/logger.dart';

/// Local stand-in for Firebase Auth: emulates the Google + Phone flows so the
/// login UI and API header injection can be built and tested without a real
/// Firebase project. Web-safe (no firebase packages, no dart:io).
class MockSocialAuthService implements SocialAuthService {
  static const String validSmsCode = '123456';

  AuthUser? _currentUser;
  String? _idToken;

  @override
  AuthUser? get currentUser => _currentUser;

  @override
  String? get idToken => _idToken;

  @override
  OmniResult<AuthUser> signInWithGoogle() async {
    const user = AuthUser(
      uid: 'mock-google-uid',
      email: 'user@example.com',
      displayName: 'Mock User',
    );
    _grant(user);
    OmniLogger.info('Mock Google sign-in for ${user.email}');
    return OmniResponse.success(user, message: 'Signed in with Google');
  }

  @override
  OmniResult<String> startPhoneVerification(String phoneNumber) async {
    if (phoneNumber.trim().isEmpty) {
      return OmniResponse.error('A phone number is required', statusCode: 400);
    }
    return OmniResponse.success('mock-verification-id',
        message: 'Verification code sent');
  }

  @override
  OmniResult<AuthUser> confirmPhoneCode(
      String verificationId, String smsCode) async {
    if (smsCode != validSmsCode) {
      OmniLogger.warning('Phone verification failed: invalid code');
      return OmniResponse.error('Invalid or expired code', statusCode: 401);
    }
    const user =
        AuthUser(uid: 'mock-phone-uid', phoneNumber: '+10000000000');
    _grant(user);
    OmniLogger.info('Mock phone verification succeeded ($verificationId)');
    return OmniResponse.success(user, message: 'Phone verified');
  }

  @override
  Future<void> signOut() async {
    _currentUser = null;
    _idToken = null;
  }

  void _grant(AuthUser user) {
    _currentUser = user;
    _idToken = 'mock-id-token-${user.uid}';
  }
}
