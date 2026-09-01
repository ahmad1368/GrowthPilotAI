import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/exponential_backoff.dart';

void main() {
  test('delay doubles each attempt starting at 2 seconds', () {
    expect(ExponentialBackoff.delayFor(0), const Duration(seconds: 2));
    expect(ExponentialBackoff.delayFor(1), const Duration(seconds: 4));
    expect(ExponentialBackoff.delayFor(2), const Duration(seconds: 8));
    expect(ExponentialBackoff.delayFor(3), const Duration(seconds: 16));
  });

  test('delay is capped at 60 seconds for large attempt counts', () {
    expect(ExponentialBackoff.delayFor(10), const Duration(seconds: 60));
  });

  test('shouldRetry stops after the max attempt count', () {
    expect(ExponentialBackoff.shouldRetry(4, maxAttempts: 5), isTrue);
    expect(ExponentialBackoff.shouldRetry(5, maxAttempts: 5), isFalse);
  });
}
