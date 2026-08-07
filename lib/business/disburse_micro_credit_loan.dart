import 'package:growth_pilot_ai/business/compute_financing_fee.dart';
import 'package:growth_pilot_ai/business/open_escrow_account.dart';
import 'package:growth_pilot_ai/core/data/entities/escrow_account_entity.dart';

/// Builds the escrow deposit for an instant checkout draw (Issue
/// #419, acceptance criterion 3) by reusing [OpenEscrowAccount]
/// (#415) rather than a separate disbursement rail — the caller
/// persists the escrow account first (to get its assigned id), then
/// builds the [MicroCreditLoanEntity] linking to it.
class DisburseMicroCreditLoan {
  static ({EscrowAccountEntity escrowAccount, double feeAmount, DateTime dueDate}) call({
    required String buyerMerchantName,
    required String sellerName,
    required String itemDescription,
    required double principal,
    required int termDays,
    required DateTime now,
  }) {
    final escrowAccount = OpenEscrowAccount.call(
      buyerName: buyerMerchantName,
      sellerName: sellerName,
      itemDescription: itemDescription,
      amount: principal,
      now: now,
    );
    return (
      escrowAccount: escrowAccount,
      feeAmount: ComputeFinancingFee.call(principal, termDays),
      dueDate: now.add(Duration(days: termDays)),
    );
  }
}
