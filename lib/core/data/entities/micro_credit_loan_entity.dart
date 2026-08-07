import 'package:objectbox/objectbox.dart';
import 'package:growth_pilot_ai/core/enum/micro_credit_loan_status.dart';

/// One short-term financing draw against a
/// [MicroCreditAccountEntity], disbursed straight into a
/// [EscrowAccountEntity] (#415) for instant purchase execution (Issue
/// #419, acceptance criterion 3).
@Entity()
class MicroCreditLoanEntity {
  @Id()
  int id = 0;

  @Index()
  int creditAccountId;

  int escrowAccountId;
  double principal;
  double feeAmount;
  int termDays;
  int dbStatus; // MicroCreditLoanStatus index

  @Property(type: PropertyType.date)
  DateTime disbursedAt;

  @Property(type: PropertyType.date)
  DateTime dueDate;

  MicroCreditLoanEntity({
    this.id = 0,
    required this.creditAccountId,
    required this.escrowAccountId,
    required this.principal,
    required this.feeAmount,
    required this.termDays,
    this.dbStatus = 0, // MicroCreditLoanStatus.disbursed
    required this.disbursedAt,
    required this.dueDate,
  });

  MicroCreditLoanStatus get status => MicroCreditLoanStatus.values[dbStatus];
  set status(MicroCreditLoanStatus value) => dbStatus = value.index;
}
