/// Canned first-line auto-response (Issue #193) — the local stand-in
/// for a human support agent; keyword-matches the user's message
/// against this app's known friction points (Plaid, OCR, Marketplace)
/// per the issue's own user story (no real agent exists here; see PR
/// notes).
class BuildAutoSupportReply {
  static String call(String userMessage) {
    final lower = userMessage.toLowerCase();
    if (lower.contains('bank') || lower.contains('plaid') || lower.contains('mfa')) {
      return "Thanks for reaching out! For bank-connection issues, double-check your bank's MFA code "
          "hasn't expired, then retry linking from Settings > Connected Accounts. A team member will "
          "follow up shortly.";
    }
    if (lower.contains('scan') || lower.contains('ocr') || lower.contains('receipt')) {
      return 'Thanks for reaching out! For scanning issues, make sure the receipt is well-lit and flat '
          'in frame. A team member will follow up shortly.';
    }
    if (lower.contains('match') || lower.contains('marketplace')) {
      return 'Thanks for reaching out! Marketplace matching can take a few minutes to refresh. A team '
          'member will follow up shortly.';
    }
    return "Thanks for reaching out! We've received your message and a team member will follow up "
        'shortly.';
  }
}
