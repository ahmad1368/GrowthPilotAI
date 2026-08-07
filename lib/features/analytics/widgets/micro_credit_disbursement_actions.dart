import 'package:growth_pilot_ai/business/build_audit_log_entry.dart';
import 'package:growth_pilot_ai/business/disburse_micro_credit_loan.dart';
import 'package:growth_pilot_ai/core/data/entities/micro_credit_account_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/micro_credit_loan_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/micro_credit_repos.dart';

/// Checkout financing draw (Issue #419, acceptance criterion 3) —
/// split out of [MicroCreditBody].
class MicroCreditDisbursementActions {
  final MicroCreditRepos repos;

  MicroCreditDisbursementActions(this.repos);

  MicroCreditLoanEntity disburse(MicroCreditAccountEntity account, String sellerName,
      String itemDescription, double principal, int termDays) {
    final now = DateTime.now();
    final draft = DisburseMicroCreditLoan.call(
      buyerMerchantName: account.merchantName,
      sellerName: sellerName,
      itemDescription: itemDescription,
      principal: principal,
      termDays: termDays,
      now: now,
    );
    final escrowId = repos.escrowAccounts.save(draft.escrowAccount);
    final loan = MicroCreditLoanEntity(
      creditAccountId: account.id,
      escrowAccountId: escrowId,
      principal: principal,
      feeAmount: draft.feeAmount,
      termDays: termDays,
      disbursedAt: now,
      dueDate: draft.dueDate,
    );
    repos.loans.save(loan);
    repos.auditLogs.record(BuildAuditLogEntry.call(
      changeType: 'disbursed micro-credit loan',
      targetMerchant: account.merchantName,
      newValue: '\$${principal.toStringAsFixed(2)} for $termDays days, '
          'fee \$${draft.feeAmount.toStringAsFixed(2)}',
    ));
    return loan;
  }
}
