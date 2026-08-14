import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/is_escrow_release_eligible.dart';

void main() {
  test('releases immediately for a low-value transaction', () {
    expect(
        IsEscrowReleaseEligible.call(
            amount: 500, buyerConfirmedDelivery: false, sellerConfirmedDelivery: false),
        isTrue);
  });

  test('holds a high-value transaction until both parties confirm', () {
    expect(
        IsEscrowReleaseEligible.call(
            amount: 5000, buyerConfirmedDelivery: true, sellerConfirmedDelivery: false),
        isFalse);
    expect(
        IsEscrowReleaseEligible.call(
            amount: 5000, buyerConfirmedDelivery: true, sellerConfirmedDelivery: true),
        isTrue);
  });
}
