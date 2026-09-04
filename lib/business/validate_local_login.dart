import '../core/constants/demo_credentials.dart';

/// [Issue #786] Local-only credential check against the fixed demo
/// account — there is no backend to validate against remotely.
class ValidateLocalLogin {
  static bool call(String email, String password) {
    return email.trim().toLowerCase() == DemoCredentials.email &&
        password == DemoCredentials.password;
  }
}
