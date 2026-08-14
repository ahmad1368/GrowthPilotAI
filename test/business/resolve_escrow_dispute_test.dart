import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/resolve_escrow_dispute.dart';
import 'package:growth_pilot_ai/core/data/entities/escrow_account_entity.dart';
import 'package:growth_pilot_ai/core/enum/escrow_status.dart';

void main() {
  final disputedAccount = EscrowAccountEntity(
    id: 7,
    buyerName: 'Buyer',
    sellerName: 'Seller',
    itemDescription: 'Espresso Machine',
    amount: 500,
    dbStatus: EscrowStatus.disputed.index,
    createdAt: DateTime(2026, 1, 1),
  );

  test('admin approving the refund marks the account refunded', () {
    final updated = ResolveEscrowDispute.call(disputedAccount, approveRefund: true);
    expect(updated.status, EscrowStatus.refunded);
  });

  test('admin siding with the seller releases the funds', () {
    final updated = ResolveEscrowDispute.call(disputedAccount, approveRefund: false);
    expect(updated.status, EscrowStatus.released);
  });
}
