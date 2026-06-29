import 'package:growth_pilot_ai/core/abstracts/base_financial_parser.dart';
import 'package:growth_pilot_ai/core/models/omni_response.dart';
import 'package:growth_pilot_ai/features/detector/models/financial_parser_request.dart';
import 'package:growth_pilot_ai/features/detector/models/financial_parser_result.dart';
import '../utils/parser_regex_patterns.dart';
import 'date_utility_parser.dart';

class FinancialParser
    extends BaseFinancialParser<FinancialParserResult, FinancialParserRequest> {
  @override
  Future<OmniResponse<FinancialParserResult>> parse(
      FinancialParserRequest req) async {
    final fullText = req.lines.join(' ');
    final date =
        DateUtilityParser.findAndNormalizeDate(req.lines) ?? DateTime.now();

    String currency = 'CAD'; // پیش‌فرض لوکیشن کانادا شما
    if (ParserRegexPatterns.usdPattern.hasMatch(fullText)) currency = 'USD';

    final result =
        FinancialParserResult(extractedDate: date, currency: currency);

    if (!validate(result)) {
      return OmniResponse.error(
          "تاریخ استخراج‌شده در آینده است و اعتبار CRA ندارد.");
    }
    return OmniResponse.success(result);
  }

  @override
  bool validate(FinancialParserResult model) {
    // عدم تایید تاریخ‌های فیک آینده (محدودیت امنیت CRA)
    return model.extractedDate
        .isBefore(DateTime.now().add(const Duration(days: 1)));
  }
}
