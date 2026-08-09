import 'package:growth_pilot_ai/business/detect_negotiation_intent.dart';
import 'package:growth_pilot_ai/business/detect_risk_flag.dart';
import 'package:growth_pilot_ai/business/extract_negotiation_terms.dart';
import 'package:growth_pilot_ai/business/generate_smart_replies.dart';
import 'package:growth_pilot_ai/core/models/negotiation_analysis.dart';

/// Ties the individual #152 detectors together into one "Negotiation
/// Prompt" pass over the recent chat, all local — no message body ever
/// leaves the device, satisfying the AC's anonymization requirement by
/// construction rather than by redaction.
class AnalyzeNegotiationChat {
  static NegotiationAnalysis call(List<String> recentMessages, String latestMessage, DateTime now) {
    final terms = ExtractNegotiationTerms.call(recentMessages, now);
    final intent = DetectNegotiationIntent.call(latestMessage);
    return (
      terms: terms,
      intent: intent,
      suggestedReplies: GenerateSmartReplies.call(intent, terms),
      riskFlagged: DetectRiskFlag.call(latestMessage),
    );
  }
}
