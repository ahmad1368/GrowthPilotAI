import 'package:growth_pilot_ai/core/enum/negotiation_intent.dart';
import 'package:growth_pilot_ai/core/models/negotiation_terms.dart';

/// One "Smart Suggestion" pass over a chat (Issue #152) — everything
/// the Co-Pilot bar needs to render, computed on-device.
typedef NegotiationAnalysis = ({
  NegotiationTerms terms,
  NegotiationIntent intent,
  List<String> suggestedReplies,
  bool riskFlagged,
});
