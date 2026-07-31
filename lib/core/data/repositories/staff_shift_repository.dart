import '../../../../objectbox.g.dart';
import '../entities/staff_shift_entity.dart';

/// Basic CRUD for logged staff shifts (Issue #379), mirroring
/// [DiscountCampaignRepository]'s insert/getAll pattern.
class StaffShiftRepository {
  final Box<StaffShiftEntity> _box;

  StaffShiftRepository(this._box);

  int insert(StaffShiftEntity shift) => _box.put(shift);

  List<StaffShiftEntity> getAll() => _box.getAll();
}
