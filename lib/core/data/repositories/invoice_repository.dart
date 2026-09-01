import '../../../../objectbox.g.dart';
import '../entities/invoice_entity.dart';

/// Thin ObjectBox wrapper for generated invoices (Issue #146).
class InvoiceRepository {
  final Box<InvoiceEntity> _box;

  InvoiceRepository(this._box);

  List<InvoiceEntity> getForRequest(int requestId) =>
      _box.getAll().where((i) => i.requestId == requestId).toList();

  /// Newest first (Issue #172's tax-summary export).
  List<InvoiceEntity> getAll() => _box.getAll()..sort((a, b) => b.createdAt.compareTo(a.createdAt));

  int insert(InvoiceEntity invoice) => _box.put(invoice);
}
