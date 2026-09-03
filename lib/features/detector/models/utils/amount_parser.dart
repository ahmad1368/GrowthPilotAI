/// Extracts the total/amount-due dollar figure from OCR'd receipt text
/// (Issue #23). Prefers a line explicitly labeled Total/Amount Due/Balance
/// Due; falls back to the largest bare "$xx.xx" figure in the text, since a
/// receipt's grand total is usually its largest line item.
class AmountParser {
  // Matches "1,250.00" (comma thousands separators) and plain "45.20" —
  // always with an exact 2-digit cents suffix so bare integers (a date's
  // year, a phone number) never qualify as an amount.
  static const _moneyGroup =
      r'(\d{1,3}(?:,\d{3})*\.\d{2}|\d+\.\d{2})';

  static final List<RegExp> _labeledTotalPatterns = [
    // \b keeps this from matching the "total" inside "Subtotal:".
    RegExp('\\b(?:grand\\s*)?total\\s*[:\\-]?\\s*\\\$?\\s*$_moneyGroup',
        caseSensitive: false),
    RegExp('amount\\s*due\\s*[:\\-]?\\s*\\\$?\\s*$_moneyGroup',
        caseSensitive: false),
    RegExp('balance\\s*due\\s*[:\\-]?\\s*\\\$?\\s*$_moneyGroup',
        caseSensitive: false),
  ];

  // The currency symbol may lead ("$15.00") or trail ("15.00$"); an amount
  // is only counted when one is present, so a bare "13.00%" isn't mistaken
  // for money.
  static final RegExp _anyDollarAmount =
      RegExp('\\\$\\s?$_moneyGroup|$_moneyGroup\\s?\\\$');

  static double? extractTotal(String text) {
    for (final pattern in _labeledTotalPatterns) {
      final match = pattern.firstMatch(text);
      if (match != null) {
        return double.tryParse(match.group(1)!.replaceAll(',', ''));
      }
    }

    final amounts = _anyDollarAmount
        .allMatches(text)
        .map((m) =>
            double.tryParse((m.group(1) ?? m.group(2))!.replaceAll(',', '')))
        .whereType<double>()
        .toList();
    if (amounts.isEmpty) return null;

    return amounts.reduce((a, b) => a > b ? a : b);
  }
}
