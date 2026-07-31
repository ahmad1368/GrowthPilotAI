import '../../../../objectbox.g.dart';
import '../entities/visitor_count_entity.dart';

/// Basic CRUD for logged visitor counts (Issue #387), mirroring
/// [DiscountCampaignRepository]'s insert/getAll pattern.
class VisitorCountRepository {
  final Box<VisitorCountEntity> _box;

  VisitorCountRepository(this._box);

  int insert(VisitorCountEntity count) => _box.put(count);

  List<VisitorCountEntity> getAll() => _box.getAll();
}
