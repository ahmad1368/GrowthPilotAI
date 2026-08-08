import 'package:growth_pilot_ai/core/data/entities/invoice_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/payment_entity.dart';
import 'package:growth_pilot_ai/core/data/repositories/payment_repository.dart';
import 'package:growth_pilot_ai/core/enum/payment_intent_status.dart';
import 'package:growth_pilot_ai/core/interfaces/payment_gateway.dart';

/// "Payment Intent API" flow (Issue #147: Created -> Processing ->
/// Succeeded/Failed) for card payments, kept out of [PaymentController]
/// for SRP.
class CardPaymentHandler {
  final PaymentGateway gateway;
  final PaymentRepository payments;

  CardPaymentHandler(this.gateway, this.payments);

  Future<PaymentEntity?> charge(InvoiceEntity invoice) async {
    final intent = await gateway.createPaymentIntent(amount: invoice.total, currency: 'CAD');
    if (!intent.success || intent.data == null) return null;

    final payment = PaymentEntity(
        invoiceId: invoice.id,
        requestId: invoice.requestId,
        buyerId: invoice.buyerId,
        sellerId: invoice.sellerId,
        amount: invoice.total,
        createdAt: DateTime.now())
      ..status = PaymentIntentStatus.processing;
    payment.id = payments.insert(payment);

    final confirmation = await gateway.confirmPayment(intent.data!);
    payment.status = (confirmation.success && confirmation.data == true)
        ? PaymentIntentStatus.succeeded
        : PaymentIntentStatus.failed;
    payment.completedAt = DateTime.now();
    payments.insert(payment);
    return payment;
  }
}
