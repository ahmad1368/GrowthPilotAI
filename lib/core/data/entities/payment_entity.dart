import 'package:objectbox/objectbox.dart';
import 'package:growth_pilot_ai/core/enum/marketplace_payment_method.dart';
import 'package:growth_pilot_ai/core/enum/payment_intent_status.dart';

/// One payment against an [InvoiceEntity] (Issue #147) — [requestId] is
/// denormalized from the invoice so completion-rate queries (#135) don't
/// need a join. This app has no real Stripe account or PCI-compliant
/// infrastructure, so no card data is ever collected here;
/// [MockPaymentGateway] simulates the intent lifecycle instead.
@Entity()
class PaymentEntity {
  @Id()
  int id = 0;

  @Index()
  int invoiceId;

  @Index()
  int requestId;

  String buyerId;
  String sellerId;
  double amount;

  int dbStatus; // PaymentIntentStatus index
  int dbMethod; // MarketplacePaymentMethod index
  String? interacReferenceNumber;

  bool buyerConfirmedDelivery;
  bool sellerConfirmedDelivery;

  @Property(type: PropertyType.date)
  DateTime createdAt;

  @Property(type: PropertyType.date)
  DateTime? completedAt;

  PaymentEntity({
    this.id = 0,
    required this.invoiceId,
    required this.requestId,
    required this.buyerId,
    required this.sellerId,
    required this.amount,
    this.dbStatus = 0, // PaymentIntentStatus.created
    this.dbMethod = 0, // MarketplacePaymentMethod.card
    this.interacReferenceNumber,
    this.buyerConfirmedDelivery = false,
    this.sellerConfirmedDelivery = false,
    required this.createdAt,
    this.completedAt,
  });

  PaymentIntentStatus get status => PaymentIntentStatus.values[dbStatus];
  set status(PaymentIntentStatus value) => dbStatus = value.index;
  MarketplacePaymentMethod get method => MarketplacePaymentMethod.values[dbMethod];
  set method(MarketplacePaymentMethod value) => dbMethod = value.index;
  bool get isSucceeded => status == PaymentIntentStatus.succeeded;
}
