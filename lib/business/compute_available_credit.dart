import 'package:growth_pilot_ai/core/data/entities/micro_credit_account_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/micro_credit_loan_entity.dart';
import 'package:growth_pilot_ai/core/enum/micro_credit_loan_status.dart';

/// Headroom left to draw against a facility (Issue #419, acceptance
/// criterion 5) — outstanding disbursed principal counts against the
/// limit; repaid/defaulted loans no longer do.
class ComputeAvailableCredit {
  static double call(MicroCreditAccountEntity account, List<MicroCreditLoanEntity> loans) {
    final outstanding = loans
        .where((l) => l.status == MicroCreditLoanStatus.disbursed)
        .fold<double>(0, (sum, l) => sum + l.principal);
    return (account.creditLimit - outstanding).clamp(0, double.infinity);
  }
}
