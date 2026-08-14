import 'package:growth_pilot_ai/business/build_audit_log_entry.dart';
import 'package:growth_pilot_ai/business/flag_loan_default.dart';
import 'package:growth_pilot_ai/business/repay_micro_credit_loan.dart';
import 'package:growth_pilot_ai/core/data/entities/micro_credit_account_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/micro_credit_loan_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/micro_credit_account_actions.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/micro_credit_repos.dart';

/// Repayment and default handling (Issue #419, acceptance criteria
/// 4-5) — split out of [MicroCreditBody].
class MicroCreditRepaymentActions {
  final MicroCreditRepos repos;
  final MicroCreditAccountActions accountActions;

  MicroCreditRepaymentActions(this.repos, this.accountActions);

  MicroCreditLoanEntity repay(MicroCreditLoanEntity loan) {
    final updated = RepayMicroCreditLoan.call(loan);
    repos.loans.save(updated);
    return updated;
  }

  ({MicroCreditLoanEntity loan, MicroCreditAccountEntity account}) flagDefault(
      MicroCreditLoanEntity loan, MicroCreditAccountEntity account) {
    final updatedLoan = FlagLoanDefault.call(loan);
    repos.loans.save(updatedLoan);
    final updatedAccount = accountActions.suspend(account);
    repos.auditLogs.record(BuildAuditLogEntry.call(
      changeType: 'flagged micro-credit default',
      targetMerchant: account.merchantName,
      previousValue: 'active',
      newValue: 'suspended',
    ));
    return (loan: updatedLoan, account: updatedAccount);
  }
}
