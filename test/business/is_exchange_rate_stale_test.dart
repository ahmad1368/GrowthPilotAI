import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/is_exchange_rate_stale.dart';

void main() {
  final fetchedAt = DateTime(2026, 1, 1, 12, 0);

  test('not stale within the 60-minute window', () {
    expect(IsExchangeRateStale.call(fetchedAt, fetchedAt.add(const Duration(minutes: 30))), isFalse);
  });

  test('stale once older than 60 minutes', () {
    expect(IsExchangeRateStale.call(fetchedAt, fetchedAt.add(const Duration(minutes: 61))), isTrue);
  });
}
