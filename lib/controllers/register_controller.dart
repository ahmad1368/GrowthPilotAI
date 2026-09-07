import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/hash_password.dart';
import 'package:growth_pilot_ai/business/validate_registration_input.dart';
import 'package:growth_pilot_ai/core/constants/auth_storage_keys.dart';
import 'package:growth_pilot_ai/services/registered_user_store.dart';
import 'package:growth_pilot_ai/services/secure_storage_service.dart';

/// [Issue #788] Owns the registration form's state. On success it persists
/// the new local account ([RegisteredUserStore]) and marks the session as
/// logged in the same way [LoginController.login] does, so registering
/// signs the user straight in without a separate login step.
class RegisterController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final errorMessage = RxnString();

  Future<bool> register() async {
    final email = emailController.text;
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    final validationError =
        ValidateRegistrationInput.call(email, password, confirmPassword);
    if (validationError != null) {
      errorMessage.value = validationError;
      return false;
    }

    if (await RegisteredUserStore.exists(email)) {
      errorMessage.value = 'An account with this email already exists';
      return false;
    }

    await RegisteredUserStore.save(email, HashPassword.call(password));
    await SecureStorageService.writeData(AuthStorageKeys.isLoggedIn, 'true');
    errorMessage.value = null;
    return true;
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
