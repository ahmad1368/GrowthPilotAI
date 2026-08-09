import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/generate_smart_replies.dart';
import 'package:growth_pilot_ai/core/enum/negotiation_intent.dart';
import 'package:growth_pilot_ai/core/models/negotiation_terms.dart';

void main() {
  const noTerms = emptyNegotiationTerms;

  test('handshake suggests confirming and sending the invoice', () {
    final replies = GenerateSmartReplies.call(NegotiationIntent.handshake, noTerms);
    expect(replies, contains("Sounds good, I'll send the invoice"));
  });

  test('accept includes the price when known', () {
    final replies = GenerateSmartReplies.call(
        NegotiationIntent.accept, (price: 100.0, quantity: null, deliveryDate: null));
    expect(replies.any((r) => r.contains('100')), isTrue);
  });

  test('counter-offer suggests 90% of the mentioned price', () {
    final replies = GenerateSmartReplies.call(
        NegotiationIntent.counterOffer, (price: 100.0, quantity: null, deliveryDate: null));
    expect(replies.any((r) => r.contains('90.00')), isTrue);
  });

  test('none falls back to generic clarifying questions', () {
    final replies = GenerateSmartReplies.call(NegotiationIntent.none, noTerms);
    expect(replies, isNotEmpty);
  });
}
