/// Rejects a non-positive transaction amount before it reaches the
/// database (Issue #12 AC) — e.g. an OCR/manual-entry amount field left
/// blank parses to 0.0 and would otherwise be silently persisted.
class ValidateTransactionAmount {
  static void call(double amount) {
    if (amount <= 0) {
      throw ArgumentError.value(
        amount,
        'amount',
        'Transaction amount must be greater than zero',
      );
    }
  }
}
