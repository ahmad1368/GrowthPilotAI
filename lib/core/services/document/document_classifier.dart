class DocumentClassifier {
  // کلمات کلیدی برای تشخیص اولیه
  static const Map<String, List<String>> _systemTemplates = {
    'رسید خرید': ['total', 'amount', 'tax', 'visa', 'debit', 'receipt'],
    'سند تعمیرات': [
      'repair',
      'service',
      'mechanic',
      'labor',
      'parts',
      'warranty'
    ],
    'فاکتور فروش': ['invoice', 'bill to', 'ship to', 'quantity', 'unit price'],
  };

  static String detect(String text) {
    final lowerText = text.toLowerCase();
    String detectedType = 'نامشخص';
    int maxMatches = 0;

    _systemTemplates.forEach((type, keywords) {
      int matches = keywords.where((k) => lowerText.contains(k)).length;
      if (matches > maxMatches) {
        maxMatches = matches;
        detectedType = type;
      }
    });

    return detectedType;
  }
}
