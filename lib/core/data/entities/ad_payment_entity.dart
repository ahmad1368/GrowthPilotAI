import 'package:objectbox/objectbox.dart';
import 'package:growth_pilot_ai/core/enum/payment_verification_status.dart';

/// One captured payment-gateway settlement for an advertising request
/// (Issue #410) — this app has no real payment gateway, so a "webhook"
/// is simulated locally and [VerifyAdPayment] matches the captured
/// amount against the package SKU price instead of a signed provider
/// callback.
@Entity()
class AdPaymentEntity {
  @Id()
  int id = 0;

  @Index()
  int advertisingRequestId;

  double amountPaid;
  int dbStatus; // PaymentVerificationStatus index

  @Property(type: PropertyType.date)
  DateTime receivedAt;

  AdPaymentEntity({
    this.id = 0,
    required this.advertisingRequestId,
    required this.amountPaid,
    required this.dbStatus,
    required this.receivedAt,
  });

  PaymentVerificationStatus get status => PaymentVerificationStatus.values[dbStatus];
  set status(PaymentVerificationStatus value) => dbStatus = value.index;
}
