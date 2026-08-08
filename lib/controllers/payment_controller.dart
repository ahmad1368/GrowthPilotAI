import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/is_escrow_release_eligible.dart';
import 'package:growth_pilot_ai/business/process_interac_payment.dart';
import 'package:growth_pilot_ai/controllers/card_payment_handler.dart';
import 'package:growth_pilot_ai/core/data/entities/invoice_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/payment_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/payment_repository.dart';
import 'package:growth_pilot_ai/core/di/dependency_injection.dart';
import 'package:growth_pilot_ai/core/enum/marketplace_payment_method.dart';
import 'package:growth_pilot_ai/core/interfaces/payment_gateway.dart';

/// "The Secure Fund Flow" (Issue #147): card charges, Interac reference
/// tracking, and delivery-confirmation-gated escrow release.
class PaymentController extends GetxController {
  late PaymentRepository _payments;
  late CardPaymentHandler _cardHandler;

  @override
  void onInit() {
    super.onInit();
    _payments = PaymentRepository(Get.find<ObjectBox>().store.box());
    _cardHandler = CardPaymentHandler(DependencyInjection.get<PaymentGateway>(), _payments);
  }

  Future<PaymentEntity?> payByCard(InvoiceEntity invoice) => _cardHandler.charge(invoice);

  PaymentEntity startInteracPayment(InvoiceEntity invoice) {
    final payment = PaymentEntity(
        invoiceId: invoice.id,
        requestId: invoice.requestId,
        buyerId: invoice.buyerId,
        sellerId: invoice.sellerId,
        amount: invoice.total,
        createdAt: DateTime.now())
      ..method = MarketplacePaymentMethod.interac;
    payment.id = _payments.insert(payment);
    return payment;
  }

  bool submitInteracReference(PaymentEntity payment, String reference) {
    final succeeded = ProcessInteracPayment.call(payment, reference, DateTime.now());
    if (succeeded) _payments.insert(payment);
    return succeeded;
  }

  void confirmDelivery(PaymentEntity payment, {required bool isBuyer}) {
    if (isBuyer) {
      payment.buyerConfirmedDelivery = true;
    } else {
      payment.sellerConfirmedDelivery = true;
    }
    _payments.insert(payment);
  }

  bool canReleaseEscrow(PaymentEntity payment) => IsEscrowReleaseEligible.call(
      amount: payment.amount,
      buyerConfirmedDelivery: payment.buyerConfirmedDelivery,
      sellerConfirmedDelivery: payment.sellerConfirmedDelivery);
}
