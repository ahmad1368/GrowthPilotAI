import 'package:growth_pilot_ai/business/is_luhn_valid.dart';

/// Redacts credit card numbers (Issue #88 AC 1) — a 13-16 digit run
/// (spaces/dashes allowed) only counts as a card if it also passes the
/// Luhn checksum, so a same-length business/reference number isn't
/// falsely redacted.
class RedactCreditCard {
  static final _candidatePattern = RegExp(r'\b\d[\d -]{11,17}\d\b');

  static String call(String text) {
    return text.replaceAllMapped(_candidatePattern, (match) {
      final digitsOnly = match.group(0)!.replaceAll(RegExp(r'[ -]'), '');
      if (digitsOnly.length < 13 || digitsOnly.length > 16) return match.group(0)!;
      return IsLuhnValid.call(digitsOnly) ? '[REDACTED_CARD]' : match.group(0)!;
    });
  }
}
