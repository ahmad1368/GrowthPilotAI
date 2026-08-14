import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/detect_financial_tag.dart';

void main() {
  test('detects a dollar-sign price mention', () {
    expect(DetectFinancialTag.call('I can do it for \$150'), isNotNull);
  });

  test('detects an exact cents amount without a dollar sign', () {
    expect(DetectFinancialTag.call('Total comes to 149.99'), isNotNull);
  });

  test('does not flag a bare quantity as financial', () {
    expect(DetectFinancialTag.call('I need 5 units delivered'), isNull);
  });

  test('does not flag ordinary text with no numbers', () {
    expect(DetectFinancialTag.call('Sounds good, see you then'), isNull);
  });
}
