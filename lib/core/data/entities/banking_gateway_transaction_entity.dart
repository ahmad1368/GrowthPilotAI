import 'package:objectbox/objectbox.dart';
import 'package:growth_pilot_ai/core/enum/banking_gateway_provider.dart';
import 'package:growth_pilot_ai/core/enum/gateway_transaction_status.dart';

/// One transaction routed through the local payment-orchestration
/// simulation (Issue #421) — this app has no real Stripe/PayPal/
/// SWIFT/SEPA integration, live forex feed, or PCI-DSS-scoped
/// infrastructure; those are explicitly out of reach for an
/// automated code-gen pipeline (no real credentials, no backend to
/// receive webhooks, and PCI-DSS is an audit, not code). This models
/// the orchestration shape only, per the user's direction. [transactionHash]
/// (Issue #423) is likewise simulated, not a real on-chain hash.
@Entity()
class BankingGatewayTransactionEntity {
  @Id()
  int id = 0;

  int dbProvider; // BankingGatewayProvider index
  String merchantName;
  String counterpartyName;
  double amount;
  String currency;
  double convertedAmount;
  double exchangeRate;
  double feeAmount;
  int dbStatus; // GatewayTransactionStatus index
  String transactionHash;

  @Property(type: PropertyType.date)
  DateTime initiatedAt;

  @Property(type: PropertyType.date)
  DateTime? settledAt;

  BankingGatewayTransactionEntity({
    this.id = 0,
    required this.dbProvider,
    required this.merchantName,
    required this.counterpartyName,
    required this.amount,
    required this.currency,
    required this.convertedAmount,
    required this.exchangeRate,
    required this.feeAmount,
    this.dbStatus = 0, // GatewayTransactionStatus.authorized
    this.transactionHash = '',
    required this.initiatedAt,
    this.settledAt,
  });

  BankingGatewayProvider get provider => BankingGatewayProvider.values[dbProvider];
  set provider(BankingGatewayProvider value) => dbProvider = value.index;

  GatewayTransactionStatus get status => GatewayTransactionStatus.values[dbStatus];
  set status(GatewayTransactionStatus value) => dbStatus = value.index;
}
