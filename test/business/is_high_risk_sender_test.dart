import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/is_high_risk_sender.dart';

void main() {
  test('high risk only when both the message is flagged and a critical strike exists', () {
    expect(
        IsHighRiskSender.call(messageFlagged: true, hasCriticalStrike: true),
        isTrue);
  });

  test('not high risk when only the message is flagged', () {
    expect(
        IsHighRiskSender.call(messageFlagged: true, hasCriticalStrike: false),
        isFalse);
  });

  test('not high risk when only a critical strike exists', () {
    expect(
        IsHighRiskSender.call(messageFlagged: false, hasCriticalStrike: true),
        isFalse);
  });
}
