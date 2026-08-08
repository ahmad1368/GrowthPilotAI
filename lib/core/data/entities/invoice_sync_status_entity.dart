import 'package:objectbox/objectbox.dart';
import 'package:growth_pilot_ai/core/enum/invoice_sync_status.dart';

/// Push state of one [InvoiceEntity]/its [PaymentEntity] to QuickBooks/
/// Xero (Issue #149) — mirrors [AccountingSyncStatusEntity] (#59)'s
/// retry/backoff bookkeeping, kept distinct since an invoice id and a
/// transaction id are different id spaces.
@Entity()
class InvoiceSyncStatusEntity {
  @Id()
  int id = 0;

  @Unique()
  int invoiceId;

  int dbStatus; // InvoiceSyncStatus index
  String? externalInvoiceId;
  int retryCount;
  DateTime? lastAttemptAt;
  DateTime? nextRetryAt;
  String? lastError;

  InvoiceSyncStatusEntity({
    this.id = 0,
    required this.invoiceId,
    this.dbStatus = 0, // InvoiceSyncStatus.pending
    this.externalInvoiceId,
    this.retryCount = 0,
    this.lastAttemptAt,
    this.nextRetryAt,
    this.lastError,
  });

  InvoiceSyncStatus get status => InvoiceSyncStatus.values[dbStatus];
  set status(InvoiceSyncStatus value) => dbStatus = value.index;
  bool get isSynced => status == InvoiceSyncStatus.synced;
}
