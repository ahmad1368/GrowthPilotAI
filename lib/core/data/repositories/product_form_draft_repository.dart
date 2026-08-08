import '../../../../objectbox.g.dart';
import '../entities/product_form_draft_entity.dart';

/// Get-or-create access to the single form-draft row (Issue #140,
/// "Resume capability").
class ProductFormDraftRepository {
  final Box<ProductFormDraftEntity> _box;

  ProductFormDraftRepository(this._box);

  ProductFormDraftEntity? get() => _box.getAll().firstOrNull;

  void save(ProductFormDraftEntity draft) {
    final existing = get();
    if (existing != null) draft.id = existing.id;
    draft.updatedAt = DateTime.now();
    _box.put(draft);
  }

  void clear() {
    final existing = get();
    if (existing != null) _box.remove(existing.id);
  }
}
