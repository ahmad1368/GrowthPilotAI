import 'package:growth_pilot_ai/business/extract_currency_amounts.dart';
import 'package:growth_pilot_ai/business/verify_amount_against_context.dart';
import 'package:growth_pilot_ai/core/enum/match_confidence.dart';
import 'package:growth_pilot_ai/core/models/response_verification.dart';

/// Orchestrates Issue #203's Verification Engine: extracts every
/// currency figure the AI mentioned and checks each against
/// [contextAmounts] — the real numbers it was actually given as RAG
/// context — OR their sum (AC: "doesn't match the sum of the provided
/// context", covering a stated total rather than one line item).
/// Overall confidence is the worst single result.
class VerifyAiResponse {
  static ResponseVerification call(String aiResponse, List<double> contextAmounts) {
    final amounts = ExtractCurrencyAmounts.call(aiResponse);
    if (amounts.isEmpty) return ResponseVerification.verified();

    final contextSum = contextAmounts.fold<double>(0, (a, b) => a + b);
    final candidates = [...contextAmounts, contextSum];

    final results = {
      for (final amount in amounts) amount: VerifyAmountAgainstContext.call(amount, candidates),
    };
    final unmatched =
        results.entries.where((e) => e.value != MatchConfidence.exact).map((e) => e.key).toList();

    final overall = results.values.contains(MatchConfidence.mismatch)
        ? MatchConfidence.mismatch
        : results.values.contains(MatchConfidence.fuzzy)
            ? MatchConfidence.fuzzy
            : MatchConfidence.exact;

    return ResponseVerification(
        overallConfidence: overall, extractedAmounts: amounts, unmatchedAmounts: unmatched);
  }
}
