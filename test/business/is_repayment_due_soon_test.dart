import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/is_repayment_due_soon.dart';
import 'package:growth_pilot_ai/core/data/entities/micro_credit_loan_entity.dart';
import 'package:growth_pilot_ai/core/enum/micro_credit_loan_status.dart';

MicroCreditLoanEntity _loan(MicroCreditLoanStatus status) {
  return MicroCreditLoanEntity(
    creditAccountId: 1,
    escrowAccountId: 1,
    principal: 100,
    feeAmount: 5,
    termDays: 30,
    dbStatus: status.index,
    disbursedAt: DateTime(2026, 1, 1),
    dueDate: DateTime(2026, 1, 31),
  );
}

void main() {
  test('not due more than the reminder window before the due date', () {
    expect(IsRepaymentDueSoon.call(_loan(MicroCreditLoanStatus.disbursed), DateTime(2026, 1, 10)), false);
  });

  test('due within the reminder window before the due date', () {
    expect(IsRepaymentDueSoon.call(_loan(MicroCreditLoanStatus.disbursed), DateTime(2026, 1, 27)), true);
  });

  test('never due once already repaid', () {
    expect(IsRepaymentDueSoon.call(_loan(MicroCreditLoanStatus.repaid), DateTime(2026, 1, 30)), false);
  });
}
