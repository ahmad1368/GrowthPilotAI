/// "Escrow/Payout Logic" (Issue #147 AC): for a high-value match, funds
/// release only once BOTH parties confirm delivery in chat; smaller
/// transactions release immediately on a successful payment.
class IsEscrowReleaseEligible {
  static const highValueThreshold = 1000.0;

  static bool call({
    required double amount,
    required bool buyerConfirmedDelivery,
    required bool sellerConfirmedDelivery,
  }) {
    if (amount < highValueThreshold) return true;
    return buyerConfirmedDelivery && sellerConfirmedDelivery;
  }
}
