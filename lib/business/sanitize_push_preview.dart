/// Lock-screen safety (Issue #71): a push notification body must never show
/// a raw dollar amount (e.g. "$54,200.00"), since lock screens are visible
/// to anyone nearby. Replaces the whole preview with a generic prompt.
class SanitizePushPreview {
  static final _amountPattern = RegExp(r'\$[\d,]+(\.\d{2})?');

  static String call(String body) => _amountPattern.hasMatch(body)
      ? 'A transaction update is available. Open the app for details.'
      : body;
}
