import 'package:growth_pilot_ai/core/enum/negotiation_intent.dart';
import 'package:growth_pilot_ai/core/models/negotiation_terms.dart';

/// "One-Tap Replies" (Issue #152) — the AI only ever suggests text for
/// a human to tap and send, matching the "Control" AC that it never
/// sends on the user's behalf.
class GenerateSmartReplies {
  static List<String> call(NegotiationIntent intent, NegotiationTerms terms) {
    switch (intent) {
      case NegotiationIntent.handshake:
        return ["Sounds good, I'll send the invoice", 'Confirmed'];
      case NegotiationIntent.accept:
        return [if (terms.price != null) 'Accept \$${terms.price}', 'Request delivery estimate'];
      case NegotiationIntent.counterOffer:
        return [
          if (terms.price != null) 'Counter-offer \$${(terms.price! * 0.9).toStringAsFixed(2)}',
          'Ask for their best price',
        ];
      case NegotiationIntent.none:
        return ['Request delivery estimate', 'Ask for quantity available'];
    }
  }
}
