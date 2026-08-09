import 'package:growth_pilot_ai/core/enum/negotiation_intent.dart';

/// Keyword-based stand-in for the issue's GPT-4o intent classification
/// (Issue #152) — checked in priority order so an explicit "deal" line
/// always wins over a milder acceptance phrase.
class DetectNegotiationIntent {
  static const _handshakeKeywords = ["sounds like a deal", "it's a deal", 'deal', 'agreed'];
  static const _acceptKeywords = ['accept', "i'll take it", 'sounds good', 'works for me'];
  static const _counterKeywords = ['counter', 'how about', 'can you do', 'what about'];

  static NegotiationIntent call(String content) {
    final lower = content.toLowerCase();
    if (_handshakeKeywords.any(lower.contains)) return NegotiationIntent.handshake;
    if (_acceptKeywords.any(lower.contains)) return NegotiationIntent.accept;
    if (_counterKeywords.any(lower.contains)) return NegotiationIntent.counterOffer;
    return NegotiationIntent.none;
  }
}
