import '../utils/parser_regex_patterns.dart';

class DateUtilityParser {
  static DateTime? findAndNormalizeDate(List<String> lines) {
    for (var line in lines) {
      for (var pattern in ParserRegexPatterns.datePatterns) {
        final match = pattern.firstMatch(line);
        if (match != null) {
          String rawStr = match.group(0)!.replaceAll('/', '-');
          // اگر سال دو رقمی بود، تبدیل به ۲۰۲۶
          if (RegExp(r'^\d{2}-\d{2}-\d{2}$').hasMatch(rawStr)) {
            rawStr = "20${rawStr.substring(6, 8)}-${rawStr.substring(0, 5)}";
          }
          return DateTime.tryParse(rawStr);
        }
      }
    }
    return null;
  }
}
