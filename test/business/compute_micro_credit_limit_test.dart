import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_micro_credit_limit.dart';
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
  test('limit is 15% of trailing revenue with no default history', () {
    expect(ComputeMicroCreditLimit.call(10000, []), closeTo(1500, 0.001));
  });

  test('one past default halves the limit', () {
    final loans = [_loan(MicroCreditLoanStatus.defaulted)];
    expect(ComputeMicroCreditLimit.call(10000, loans), closeTo(750, 0.001));
  });

  test('two past defaults quarter the limit', () {
    final loans = [_loan(MicroCreditLoanStatus.defaulted), _loan(MicroCreditLoanStatus.defaulted)];
    expect(ComputeMicroCreditLimit.call(10000, loans), closeTo(375, 0.001));
  });

  test('repaid loans do not affect the limit', () {
    final loans = [_loan(MicroCreditLoanStatus.repaid)];
    expect(ComputeMicroCreditLimit.call(10000, loans), closeTo(1500, 0.001));
  });
}
