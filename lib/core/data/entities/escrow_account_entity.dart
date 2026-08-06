import 'package:objectbox/objectbox.dart';
import 'package:growth_pilot_ai/core/enum/escrow_status.dart';

/// A programmatic escrow account holding buyer funds for one
/// marketplace transaction until fulfillment or refund conditions are
/// met (Issue #415) — this app has no blockchain/payment-processing
/// backend, so "smart contract" logic is this entity's status
/// transitions plus [BuildAuditLogEntry] transaction logging.
@Entity()
class EscrowAccountEntity {
  @Id()
  int id = 0;

  String buyerName;
  String sellerName;
  String itemDescription;
  double amount;
  int dbStatus; // EscrowStatus index

  @Property(type: PropertyType.date)
  DateTime createdAt;

  EscrowAccountEntity({
    this.id = 0,
    required this.buyerName,
    required this.sellerName,
    required this.itemDescription,
    required this.amount,
    this.dbStatus = 0, // EscrowStatus.held
    required this.createdAt,
  });

  EscrowStatus get status => EscrowStatus.values[dbStatus];
  set status(EscrowStatus value) => dbStatus = value.index;
}
