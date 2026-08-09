import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/detect_negotiation_intent.dart';
import 'package:growth_pilot_ai/core/enum/negotiation_intent.dart';

void main() {
  test('detects a handshake', () {
    expect(DetectNegotiationIntent.call("Sounds like a deal!"), NegotiationIntent.handshake);
  });

  test('detects an accept', () {
    expect(DetectNegotiationIntent.call("I'll take it"), NegotiationIntent.accept);
  });

  test('detects a counter-offer', () {
    expect(DetectNegotiationIntent.call('How about \$80 instead?'), NegotiationIntent.counterOffer);
  });

  test('defaults to none for unrelated chat', () {
    expect(DetectNegotiationIntent.call('What time works for you?'), NegotiationIntent.none);
  });

  test('handshake takes priority over a milder accept phrase', () {
    expect(DetectNegotiationIntent.call('Sounds good, deal!'), NegotiationIntent.handshake);
  });
}
