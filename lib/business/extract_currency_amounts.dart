/// Extracts every "$XXX.XX"-style currency amount from [text] (Issue
/// #203's "Regex Scraper... extract all currency amounts").
class ExtractCurrencyAmounts {
  static final _pattern = RegExp(r'\$([\d,]+(?:\.\d{1,2})?)');

  static List<double> call(String text) => _pattern
      .allMatches(text)
      .map((m) => double.tryParse(m.group(1)!.replaceAll(',', '')))
      .whereType<double>()
      .toList();
}
