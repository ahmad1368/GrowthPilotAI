class OmniParser {
  /// تشخیص نوع ارز بر اساس نمادهای موجود در متن
  static String detectCurrency(String text) {
    if (text.contains('CAD') || text.contains('C\$')) return "CAD 🇨🇦";
    if (text.contains('\$') || text.contains('USD')) return "USD 🇺🇸";
    return "CAD 🇨🇦"; // پیش‌فرض برای منطقه BC
  }

  /// استخراج مالیات (GST/HST/PST) برای گزارش‌های فصلی کانادا
  static Map<String, double> extractTaxes(String text) {
    final Map<String, double> taxes = {};

    // رگکس برای پیدا کردن اعدادی که جلوی کلمات مالیاتی می‌آیند
    final gstRegex =
        RegExp(r'(GST|HST|Tax)\s*:?\s*\$?(\d+\.\d{2})', caseSensitive: false);
    final pstRegex =
        RegExp(r'PST\s*:?\s*\$?(\d+\.\d{2})', caseSensitive: false);

    final gstMatch = gstRegex.firstMatch(text);
    if (gstMatch != null) {
      taxes['GST/HST'] = double.tryParse(gstMatch.group(2) ?? '0') ?? 0;
    }

    final pstMatch = pstRegex.firstMatch(text);
    if (pstMatch != null) {
      taxes['PST'] = double.tryParse(pstMatch.group(2) ?? '0') ?? 0;
    }

    return taxes;
  }
}
