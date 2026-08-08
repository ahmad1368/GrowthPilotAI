import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/submit_procurement_response.dart';

void main() {
  final now = DateTime(2026, 1, 1);

  test('a Quick Quote sets the quote amount', () {
    final response = SubmitProcurementResponse.call(
        requestId: 1, providerId: 'vendor-1', message: r'I can do it for $150', quoteAmount: 150, now: now);
    expect(response.isQuote, isTrue);
    expect(response.quoteAmount, 150);
  });

  test('a Request for More Info has no quote amount', () {
    final response = SubmitProcurementResponse.call(
        requestId: 1, providerId: 'vendor-1', message: 'What parts do you need replaced?', now: now);
    expect(response.isQuote, isFalse);
    expect(response.quoteAmount, isNull);
  });
}
