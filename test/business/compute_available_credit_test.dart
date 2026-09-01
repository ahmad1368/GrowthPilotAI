import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_available_credit.dart';
import 'package:growth_pilot_ai/core/data/entities/micro_credit_account_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/micro_credit_loan_entity.dart';
import 'package:growth_pilot_ai/core/enum/micro_credit_loan_status.dart';

MicroCreditLoanEntity _loan(double principal, MicroCreditLoanStatus status) {
  return MicroCreditLoanEntity(
    creditAccountId: 1,
    escrowAccountId: 1,
    principal: principal,
    feeAmount: 5,
    termDays: 30,
    dbStatus: status.index,
    disbursedAt: DateTime(2026, 1, 1),
    dueDate: DateTime(2026, 1, 31),
  );
}

void main() {
  final account =
      MicroCreditAccountEntity(id: 1, merchantName: 'Merchant', creditLimit: 1000, createdAt: DateTime(2026, 1, 1));

  test('outstanding disbursed loans reduce available credit', () {
    final loans = [_loan(300, MicroCreditLoanStatus.disbursed)];
    expect(ComputeAvailableCredit.call(account, loans), closeTo(700, 0.001));
  });

  test('repaid and defaulted loans no longer count against the limit', () {
    final loans = [
      _loan(300, MicroCreditLoanStatus.repaid),
      _loan(200, MicroCreditLoanStatus.defaulted),
    ];
    expect(ComputeAvailableCredit.call(account, loans), closeTo(1000, 0.001));
  });

  test('available credit never goes negative', () {
    final loans = [_loan(1500, MicroCreditLoanStatus.disbursed)];
    expect(ComputeAvailableCredit.call(account, loans), 0);
  });
}
