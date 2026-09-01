import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/flag_loan_default.dart';
import 'package:growth_pilot_ai/business/suspend_credit_account.dart';
import 'package:growth_pilot_ai/core/data/entities/micro_credit_account_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/micro_credit_loan_entity.dart';
import 'package:growth_pilot_ai/core/enum/micro_credit_account_status.dart';
import 'package:growth_pilot_ai/core/enum/micro_credit_loan_status.dart';

void main() {
  test('flagging a default marks the loan defaulted', () {
    final loan = MicroCreditLoanEntity(
      id: 3,
      creditAccountId: 1,
      escrowAccountId: 1,
      principal: 100,
      feeAmount: 5,
      termDays: 30,
      disbursedAt: DateTime(2026, 1, 1),
      dueDate: DateTime(2026, 1, 31),
    );

    final updated = FlagLoanDefault.call(loan);

    expect(updated.status, MicroCreditLoanStatus.defaulted);
    expect(updated.id, 3);
  });

  test('suspending an account marks it suspended', () {
    final account = MicroCreditAccountEntity(
        id: 1, merchantName: 'Merchant', creditLimit: 500, createdAt: DateTime(2026, 1, 1));

    final updated = SuspendCreditAccount.call(account);

    expect(updated.status, MicroCreditAccountStatus.suspended);
    expect(updated.creditLimit, 500);
  });
}
