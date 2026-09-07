/// [Issue #788] Pure validation for the registration form: required
/// fields, a plausible email shape, a minimum password length, and that
/// password/confirmPassword match. Returns a user-facing error message,
/// or null when the input is valid — mirrors how [ValidateLocalLogin]
/// keeps auth business logic separate from the controller/widget layer.
class ValidateRegistrationInput {
  static final _emailPattern = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
  static const minPasswordLength = 8;

  static String? call(String email, String password, String confirmPassword) {
    final trimmedEmail = email.trim();
    if (trimmedEmail.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      return 'All fields are required';
    }
    if (!_emailPattern.hasMatch(trimmedEmail)) {
      return 'Enter a valid email address';
    }
    if (password.length < minPasswordLength) {
      return 'Password must be at least $minPasswordLength characters';
    }
    if (password != confirmPassword) {
      return 'Passwords do not match';
    }
    return null;
  }
}
