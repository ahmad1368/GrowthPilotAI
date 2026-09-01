import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/detect_risk_flag.dart';

void main() {
  test('flags a message containing risky language', () {
    expect(DetectRiskFlag.call('This looks like a scam to me'), isTrue);
  });

  test('does not flag ordinary negotiation language', () {
    expect(DetectRiskFlag.call('Can you do \$100 for the lot?'), isFalse);
  });
}
