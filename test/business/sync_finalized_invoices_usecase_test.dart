import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/sync_finalized_invoices_usecase.dart';
import 'package:growth_pilot_ai/core/data/entities/invoice_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/invoice_sync_status_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/payment_entity.dart';
import 'package:growth_pilot_ai/core/enum/invoice_sync_status.dart';
import 'package:growth_pilot_ai/core/enum/payment_intent_status.dart';
import 'package:growth_pilot_ai/core/interfaces/accounting_export_service.dart';
import 'package:growth_pilot_ai/core/models/omni_response.dart';

class _SpyExportService implements AccountingExportService {
  bool succeeds;
  int pushInvoiceCalls = 0;
  int pushPaymentCalls = 0;
  _SpyExportService({this.succeeds = true});

  @override
  OmniResult<String> pushTransaction({required int transactionId, required String accountId}) async =>
      OmniResponse.success('unused');

  @override
  OmniResult<String> pushInvoice({required int invoiceId, required String accountId}) async {
    pushInvoiceCalls++;
    return succeeds ? OmniResponse.success('ext-inv-$invoiceId') : OmniResponse.error('down');
  }

  @override
  OmniResult<void> pushPayment({required int paymentId, required String externalInvoiceId}) async {
    pushPaymentCalls++;
    return OmniResponse.success(null);
  }
}

void main() {
  final now = DateTime(2026, 1, 1);

  InvoiceEntity invoice(int id) => InvoiceEntity(
      id: id, requestId: 1, sellerId: 'vendor', buyerId: 'buyer', subtotal: 100, gst: 5, pst: 7,
      total: 112, pdfBytes: Uint8List(0), createdAt: now);

  PaymentEntity payment(int invoiceId, {PaymentIntentStatus status = PaymentIntentStatus.succeeded}) =>
      PaymentEntity(invoiceId: invoiceId, requestId: 1, buyerId: 'buyer', sellerId: 'vendor', amount: 112,
          createdAt: now)
        ..status = status;

  test('pushes both the invoice and its payment on success', () async {
    final service = _SpyExportService();
    final inv = invoice(1);
    await SyncFinalizedInvoicesUseCase(service).syncAll([inv], [payment(1)], [], 'acc-1');

    expect(service.pushInvoiceCalls, 1);
    expect(service.pushPaymentCalls, 1);
  });

  test('skips an invoice with no succeeded payment yet', () async {
    final service = _SpyExportService();
    await SyncFinalizedInvoicesUseCase(service)
        .syncAll([invoice(1)], [payment(1, status: PaymentIntentStatus.processing)], [], 'acc-1');

    expect(service.pushInvoiceCalls, 0);
  });

  test('does not re-push an already-synced invoice', () async {
    final service = _SpyExportService();
    final synced = InvoiceSyncStatusEntity(invoiceId: 1)..status = InvoiceSyncStatus.synced;
    await SyncFinalizedInvoicesUseCase(service).syncAll([invoice(1)], [payment(1)], [synced], 'acc-1');

    expect(service.pushInvoiceCalls, 0);
  });

  test('a failed invoice push does not also attempt the payment push', () async {
    final service = _SpyExportService(succeeds: false);
    await SyncFinalizedInvoicesUseCase(service).syncAll([invoice(1)], [payment(1)], [], 'acc-1');

    expect(service.pushInvoiceCalls, 1);
    expect(service.pushPaymentCalls, 0);
  });
}
