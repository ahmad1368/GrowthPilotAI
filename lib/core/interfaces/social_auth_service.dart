import 'package:growth_pilot_ai/core/models/auth_user.dart';
import 'package:growth_pilot_ai/core/models/omni_response.dart';

/// Contract for social authentication (Google + Phone). A real
/// Firebase-backed implementation can drop in later behind this interface; the
/// [idToken] is what callers attach to the API `Authorization` header.
abstract class SocialAuthService {
  AuthUser? get currentUser;

  /// In-memory Firebase ID token for the current session (null when signed out).
  String? get idToken;

  OmniResult<AuthUser> signInWithGoogle();

  /// Kicks off SMS verification; the resolved data is a verificationId.
  OmniResult<String> startPhoneVerification(String phoneNumber);

  OmniResult<AuthUser> confirmPhoneCode(String verificationId, String smsCode);

  Future<void> signOut();
}
