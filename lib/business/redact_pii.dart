import 'package:growth_pilot_ai/business/redact_credit_card.dart';
import 'package:growth_pilot_ai/business/redact_email.dart';
import 'package:growth_pilot_ai/business/redact_sin.dart';

/// "Level 1 (Internal)" redaction (Issue #88): the version stored in the
/// message log. Runs each pattern-specific redactor in sequence; the
/// result is a one-way transformation — there is no unmasking path, so
/// the original text is never recoverable from what this returns
/// (Issue #88 AC: "Redacted data is irreversible").
class RedactPii {
  static String call(String text) {
    var result = text;
    result = RedactSin.call(result);
    result = RedactCreditCard.call(result);
    result = RedactEmail.call(result);
    return result;
  }
}
