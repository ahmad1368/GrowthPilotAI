/// Extracts the total/amount-due dollar figure from OCR'd receipt text
/// (Issue #23). Prefers a line explicitly labeled Total/Amount Due/Balance
/// Due; falls back to the largest bare "$xx.xx" figure in the text, since a
/// receipt's grand total is usually its largest line item.
class AmountParser {
  static final List<RegExp> _labeledTotalPatterns = [
    // \b keeps this from matching the "total" inside "Subtotal:".
    RegExp(r'\b(?:grand\s*)?total\s*[:\-]?\s*\$?\s*(\d+[.,]\d{2})',
        caseSensitive: false),
    RegExp(r'amount\s*due\s*[:\-]?\s*\$?\s*(\d+[.,]\d{2})',
        caseSensitive: false),
    RegExp(r'balance\s*due\s*[:\-]?\s*\$?\s*(\d+[.,]\d{2})',
        caseSensitive: false),
  ];

  static final RegExp _anyDollarAmount = RegExp(r'\$\s?(\d+[.,]\d{2})');

  static double? extractTotal(String text) {
    for (final pattern in _labeledTotalPatterns) {
      final match = pattern.firstMatch(text);
      if (match != null) {
        return double.tryParse(match.group(1)!.replaceAll(',', '.'));
      }
    }

    final amounts = _anyDollarAmount
        .allMatches(text)
        .map((m) => double.tryParse(m.group(1)!.replaceAll(',', '.')))
        .whereType<double>()
        .toList();
    if (amounts.isEmpty) return null;

    return amounts.reduce((a, b) => a > b ? a : b);
  }
}
