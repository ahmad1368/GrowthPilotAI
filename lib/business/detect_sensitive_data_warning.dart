import 'package:growth_pilot_ai/business/redact_credit_card.dart';
import 'package:growth_pilot_ai/business/redact_sin.dart';

/// "Real-time Feedback" (Issue #88 scope item 3): while a user is typing
/// a chat message, warn them before they send text that looks like a SIN
/// or a valid credit card number. Returns null when nothing is flagged.
class DetectSensitiveDataWarning {
  static String? call(String draftText) {
    if (draftText.isEmpty) return null;
    final looksSensitive =
        RedactSin.call(draftText) != draftText || RedactCreditCard.call(draftText) != draftText;
    return looksSensitive
        ? 'Warning: avoid sharing sensitive financial identifiers in chat.'
        : null;
  }
}
