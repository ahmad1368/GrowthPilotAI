import 'package:growth_pilot_ai/business/hash_password.dart';
import 'package:growth_pilot_ai/business/validate_local_login.dart';
import 'package:growth_pilot_ai/services/registered_user_store.dart';

/// [Issue #788] Accepts either the fixed demo account
/// ([ValidateLocalLogin]) or a locally-registered account
/// ([RegisteredUserStore]), so registering a new account doesn't lock a
/// user out of the original demo credentials.
class ValidateLogin {
  static Future<bool> call(String email, String password) async {
    if (ValidateLocalLogin.call(email, password)) return true;

    final storedHash = await RegisteredUserStore.passwordHashOf(email);
    if (storedHash == null) return false;
    return storedHash == HashPassword.call(password);
  }
}
