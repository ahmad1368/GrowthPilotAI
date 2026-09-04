import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/validate_local_login.dart';
import 'package:growth_pilot_ai/core/constants/demo_credentials.dart';
import 'package:growth_pilot_ai/services/secure_storage_service.dart';

/// [Issue #786] Owns the login form's state and the persisted "logged in"
/// flag. [autoFillForDebug] defaults to the real Flutter SDK `kDebugMode`
/// constant (compiled out of release/profile builds entirely) — exposed
/// as a constructor param, rather than reading `kDebugMode` inline, so
/// both the debug-prefill and release-empty branches are directly
/// testable without needing to flip a compile-time constant.
class LoginController extends GetxController {
  static const _storageKey = 'is_logged_in';

  LoginController({bool autoFillForDebug = kDebugMode})
      : _autoFillForDebug = autoFillForDebug;

  final bool _autoFillForDebug;

  late final emailController =
      TextEditingController(text: _autoFillForDebug ? DemoCredentials.email : '');
  late final passwordController = TextEditingController(
      text: _autoFillForDebug ? DemoCredentials.password : '');

  final errorMessage = RxnString();
  bool isLoggedIn = false;

  Future<void> restore() async {
    final stored = await SecureStorageService.readData(_storageKey);
    isLoggedIn = stored == 'true';
  }

  Future<bool> login() async {
    final valid =
        ValidateLocalLogin.call(emailController.text, passwordController.text);
    if (!valid) {
      errorMessage.value = 'Invalid email or password';
      return false;
    }
    errorMessage.value = null;
    isLoggedIn = true;
    await SecureStorageService.writeData(_storageKey, 'true');
    return true;
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
