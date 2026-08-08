import '../../../../objectbox.g.dart';
import '../entities/block_entity.dart';

/// Thin ObjectBox wrapper for block relationships (Issue #124/#134).
class BlockRepository {
  final Box<BlockEntity> _box;

  BlockRepository(this._box);

  List<BlockEntity> getAll() => _box.getAll();

  int insert(BlockEntity block) => _box.put(block);

  void remove(String blockerId, String blockedId) {
    final query = _box
        .query(BlockEntity_.blockerId.equals(blockerId)
            .and(BlockEntity_.blockedId.equals(blockedId)))
        .build();
    final matches = query.find();
    query.close();
    _box.removeMany(matches.map((m) => m.id).toList());
  }
}
