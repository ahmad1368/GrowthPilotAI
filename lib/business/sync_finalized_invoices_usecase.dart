import 'package:growth_pilot_ai/business/exponential_backoff.dart';
import 'package:growth_pilot_ai/business/find_or_create_invoice_sync_status.dart';
import 'package:growth_pilot_ai/core/data/entities/invoice_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/invoice_sync_status_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/payment_entity.dart';
import 'package:growth_pilot_ai/core/enum/invoice_sync_status.dart';
import 'package:growth_pilot_ai/core/interfaces/accounting_export_service.dart';

/// "Real-Time Sync Engine" (Issue #149): pushes every finalized (paid)
/// invoice and its payment status to QuickBooks/Xero, mirroring
/// [SyncConfirmedTransactionsUseCase] (#59)'s retry/backoff bookkeeping.
class SyncFinalizedInvoicesUseCase {
  final AccountingExportService _exportService;

  SyncFinalizedInvoicesUseCase(this._exportService);

  Future<void> syncAll(List<InvoiceEntity> invoices, List<PaymentEntity> payments,
      List<InvoiceSyncStatusEntity> existingStatuses, String accountId) async {
    for (final invoice in invoices) {
      final payment = payments.where((p) => p.invoiceId == invoice.id && p.isSucceeded).firstOrNull;
      if (payment == null) continue;

      final status = FindOrCreateInvoiceSyncStatus.call(existingStatuses, invoice.id);
      if (status.isSynced || !_isDue(status)) continue;
      await _pushOne(status, invoice, payment, accountId);
    }
  }

  bool _isDue(InvoiceSyncStatusEntity status) {
    final nextRetryAt = status.nextRetryAt;
    return nextRetryAt == null || !DateTime.now().isBefore(nextRetryAt);
  }

  Future<void> _pushOne(InvoiceSyncStatusEntity status, InvoiceEntity invoice,
      PaymentEntity payment, String accountId) async {
    status.lastAttemptAt = DateTime.now();
    final invoiceResponse =
        await _exportService.pushInvoice(invoiceId: invoice.id, accountId: accountId);

    if (invoiceResponse.success && invoiceResponse.data != null) {
      await _exportService.pushPayment(
          paymentId: payment.id, externalInvoiceId: invoiceResponse.data!);
      status.status = InvoiceSyncStatus.synced;
      status.externalInvoiceId = invoiceResponse.data;
      status.lastError = null;
      status.nextRetryAt = null;
      return;
    }
    status.status = InvoiceSyncStatus.failed;
    status.retryCount += 1;
    status.lastError = invoiceResponse.message ?? 'Unknown export error';
    status.nextRetryAt = DateTime.now().add(ExponentialBackoff.delayFor(status.retryCount - 1));
  }
}
