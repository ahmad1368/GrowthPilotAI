import '../../../../objectbox.g.dart';
import '../entities/vendor_entity.dart';

/// Basic CRUD for suppliers/vendors (Issue #442), mirroring
/// [InventoryItemRepository]'s insert/getAll pattern.
class VendorRepository {
  final Box<VendorEntity> _box;

  VendorRepository(this._box);

  int insert(VendorEntity vendor) => _box.put(vendor);

  List<VendorEntity> getAll() => _box.getAll();
}
