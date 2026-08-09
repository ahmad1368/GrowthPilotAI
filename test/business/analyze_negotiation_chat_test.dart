import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/analyze_negotiation_chat.dart';
import 'package:growth_pilot_ai/core/enum/negotiation_intent.dart';

void main() {
  final now = DateTime(2026, 3, 10);

  test('combines term extraction, intent, replies, and risk flagging', () {
    final result = AnalyzeNegotiationChat.call(
        ['How about \$100 for 10 units?'], 'Sounds like a deal!', now);

    expect(result.terms.price, 100.0);
    expect(result.terms.quantity, 10);
    expect(result.intent, NegotiationIntent.handshake);
    expect(result.suggestedReplies, isNotEmpty);
    expect(result.riskFlagged, isFalse);
  });

  test('flags a risky latest message', () {
    final result = AnalyzeNegotiationChat.call([], 'This is a scam', now);
    expect(result.riskFlagged, isTrue);
  });
}
