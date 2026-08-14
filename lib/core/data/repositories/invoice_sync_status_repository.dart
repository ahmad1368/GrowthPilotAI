import '../../../../objectbox.g.dart';
import '../entities/invoice_sync_status_entity.dart';

/// Thin ObjectBox wrapper for invoice accounting-sync statuses (Issue #149).
class InvoiceSyncStatusRepository {
  final Box<InvoiceSyncStatusEntity> _box;

  InvoiceSyncStatusRepository(this._box);

  List<InvoiceSyncStatusEntity> getAll() => _box.getAll();

  InvoiceSyncStatusEntity? getForInvoice(int invoiceId) {
    final query = _box.query(InvoiceSyncStatusEntity_.invoiceId.equals(invoiceId)).build();
    final result = query.findFirst();
    query.close();
    return result;
  }

  int upsert(InvoiceSyncStatusEntity status) => _box.put(status);
}
