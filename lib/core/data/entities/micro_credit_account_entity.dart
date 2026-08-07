import 'package:objectbox/objectbox.dart';
import 'package:growth_pilot_ai/core/enum/micro_credit_account_status.dart';

/// A merchant's internal short-term working-capital facility (Issue
/// #419) — this app has no real lender/credit-bureau backend, so the
/// limit is computed locally from this device's own transaction
/// history via [ComputeMicroCreditLimit].
@Entity()
class MicroCreditAccountEntity {
  @Id()
  int id = 0;

  String merchantName;
  double creditLimit;
  int dbStatus; // MicroCreditAccountStatus index

  @Property(type: PropertyType.date)
  DateTime createdAt;

  MicroCreditAccountEntity({
    this.id = 0,
    required this.merchantName,
    required this.creditLimit,
    this.dbStatus = 0, // MicroCreditAccountStatus.active
    required this.createdAt,
  });

  MicroCreditAccountStatus get status => MicroCreditAccountStatus.values[dbStatus];
  set status(MicroCreditAccountStatus value) => dbStatus = value.index;
}
