/// Validates a Canadian CRA Business Number (BN): exactly 9 digits. Spaces and
/// dashes are tolerated in input and stripped before checking.
class BusinessNumberValidator {
  static final RegExp _nineDigits = RegExp(r'^\d{9}$');

  static String normalize(String input) =>
      input.replaceAll(RegExp(r'[\s-]'), '');

  static bool isValid(String? input) {
    if (input == null) return false;
    return _nineDigits.hasMatch(normalize(input));
  }
}
