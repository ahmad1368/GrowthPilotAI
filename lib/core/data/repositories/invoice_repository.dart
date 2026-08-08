import '../../../../objectbox.g.dart';
import '../entities/invoice_entity.dart';

/// Thin ObjectBox wrapper for generated invoices (Issue #146).
class InvoiceRepository {
  final Box<InvoiceEntity> _box;

  InvoiceRepository(this._box);

  List<InvoiceEntity> getForRequest(int requestId) =>
      _box.getAll().where((i) => i.requestId == requestId).toList();

  int insert(InvoiceEntity invoice) => _box.put(invoice);
}
