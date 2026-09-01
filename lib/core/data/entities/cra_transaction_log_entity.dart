import 'package:objectbox/objectbox.dart';
import 'package:growth_pilot_ai/core/enum/tax_category.dart';

/// One immutable CRA-compliance ledger entry derived from a settled
/// [BankingGatewayTransactionEntity] (Issue #428, acceptance criteria
/// 1-2 and 5) — [counterpartyNameEncrypted] is AES-256 ciphertext
/// (see [FieldCipher]), never plaintext, and [checksum] is a SHA-256
/// hash of this entry's own stored fields so tampering can be
/// detected after the fact; there is no update/delete path in
/// [CraTransactionLogRepository], so an entry can only ever be
/// appended, never altered.
@Entity()
class CraTransactionLogEntity {
  @Id()
  int id = 0;

  @Index()
  int gatewayTransactionId;

  String counterpartyNameEncrypted;
  double amount;
  String currency;
  double exchangeRateAtSettlement;
  double feeAmount;
  String transactionHash;
  int dbTaxCategory;
  String checksum;

  @Index()
  @Property(type: PropertyType.date)
  DateTime loggedAt;

  CraTransactionLogEntity({
    this.id = 0,
    required this.gatewayTransactionId,
    required this.counterpartyNameEncrypted,
    required this.amount,
    required this.currency,
    required this.exchangeRateAtSettlement,
    required this.feeAmount,
    required this.transactionHash,
    this.dbTaxCategory = 0,
    required this.checksum,
    required this.loggedAt,
  });

  TaxCategory get taxCategory => TaxCategory.values[dbTaxCategory];
  set taxCategory(TaxCategory value) => dbTaxCategory = value.index;
}
