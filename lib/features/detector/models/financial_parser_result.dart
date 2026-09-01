class FinancialParserResult {
  final DateTime extractedDate;
  final String currency;

  /// The parsed total/amount-due (Issue #23) — null when no dollar figure
  /// could be found in the OCR'd text, e.g. a non-receipt document.
  final double? amount;

  const FinancialParserResult({
    required this.extractedDate,
    required this.currency,
    this.amount,
  });
}
