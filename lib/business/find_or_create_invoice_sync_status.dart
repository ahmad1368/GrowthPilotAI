import 'package:growth_pilot_ai/core/data/entities/invoice_sync_status_entity.dart';

/// One sync-status row per invoice (Issue #149) — reuses the existing
/// row if this invoice was already tracked.
class FindOrCreateInvoiceSyncStatus {
  static InvoiceSyncStatusEntity call(List<InvoiceSyncStatusEntity> existing, int invoiceId) {
    for (final status in existing) {
      if (status.invoiceId == invoiceId) return status;
    }
    return InvoiceSyncStatusEntity(invoiceId: invoiceId);
  }
}
