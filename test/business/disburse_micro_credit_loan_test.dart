import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/disburse_micro_credit_loan.dart';

void main() {
  test('disbursing builds a held escrow account for the principal amount', () {
    final draft = DisburseMicroCreditLoan.call(
      buyerMerchantName: 'Merchant',
      sellerName: 'Supplier',
      itemDescription: 'Espresso Machine',
      principal: 1000,
      termDays: 30,
      now: DateTime(2026, 1, 1),
    );

    expect(draft.escrowAccount.buyerName, 'Merchant');
    expect(draft.escrowAccount.sellerName, 'Supplier');
    expect(draft.escrowAccount.amount, 1000);
    expect(draft.feeAmount, closeTo(30, 0.001));
    expect(draft.dueDate, DateTime(2026, 1, 31));
  });
}
