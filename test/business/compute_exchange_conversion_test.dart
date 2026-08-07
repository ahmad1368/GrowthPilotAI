import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_exchange_conversion.dart';

void main() {
  test('CAD to CAD is a 1:1 no-op conversion', () {
    final result = ComputeExchangeConversion.call(100, 'CAD');
    expect(result.exchangeRate, 1.0);
    expect(result.convertedAmount, 100);
  });

  test('applies the configured rate for a known foreign currency', () {
    final result = ComputeExchangeConversion.call(100, 'USD');
    expect(result.exchangeRate, ComputeExchangeConversion.ratesToCad['USD']);
    expect(result.convertedAmount, closeTo(135.0, 0.001));
  });

  test('is case-insensitive on the currency code', () {
    final result = ComputeExchangeConversion.call(100, 'usd');
    expect(result.exchangeRate, ComputeExchangeConversion.ratesToCad['USD']);
  });

  test('an unknown currency defaults to parity rather than failing', () {
    final result = ComputeExchangeConversion.call(100, 'XYZ');
    expect(result.exchangeRate, 1.0);
    expect(result.convertedAmount, 100);
  });

  test('stablecoins convert at the same rate as their USD peg (Issue #423)', () {
    final usdt = ComputeExchangeConversion.call(100, 'USDT');
    expect(usdt.exchangeRate, ComputeExchangeConversion.ratesToCad['USD']);
  });

  test('applies the configured static rate for a volatile crypto asset (Issue #423)', () {
    final btc = ComputeExchangeConversion.call(1, 'BTC');
    expect(btc.exchangeRate, ComputeExchangeConversion.ratesToCad['BTC']);
  });
}
