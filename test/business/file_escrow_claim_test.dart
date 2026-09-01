import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/file_escrow_claim.dart';
import 'package:growth_pilot_ai/core/data/entities/escrow_account_entity.dart';
import 'package:growth_pilot_ai/core/enum/escrow_claim_reason.dart';
import 'package:growth_pilot_ai/core/enum/escrow_status.dart';

void main() {
  final account = EscrowAccountEntity(
    id: 4,
    buyerName: 'Buyer',
    sellerName: 'Seller',
    itemDescription: 'Espresso Machine',
    amount: 500,
    createdAt: DateTime(2026, 1, 1),
  );

  test('a damaged claim auto-resolves to refunded', () {
    final updated = FileEscrowClaim.call(account, EscrowClaimReason.damaged);
    expect(updated.status, EscrowStatus.refunded);
    expect(updated.id, 4);
  });

  test('an ambiguous "other" claim escalates to disputed', () {
    final updated = FileEscrowClaim.call(account, EscrowClaimReason.other);
    expect(updated.status, EscrowStatus.disputed);
  });
}
