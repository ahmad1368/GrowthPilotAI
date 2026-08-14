/// Luhn checksum (Issue #88 AC: "Ensure the Regex is specific enough to
/// not redact common business numbers ... unless they match PII patterns
/// exactly") — a digit-length match alone isn't enough to call something
/// a credit card number; this filters out the false positives.
class IsLuhnValid {
  static bool call(String digitsOnly) {
    if (digitsOnly.isEmpty) return false;
    var sum = 0;
    var doubleDigit = false;
    for (var i = digitsOnly.length - 1; i >= 0; i--) {
      var digit = int.parse(digitsOnly[i]);
      if (doubleDigit) {
        digit *= 2;
        if (digit > 9) digit -= 9;
      }
      sum += digit;
      doubleDigit = !doubleDigit;
    }
    return sum % 10 == 0;
  }
}
