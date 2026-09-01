import '../../../../objectbox.g.dart';
import '../entities/strike_entity.dart';

/// Thin ObjectBox wrapper for reputation strikes (Issue #124).
class StrikeRepository {
  final Box<StrikeEntity> _box;

  StrikeRepository(this._box);

  List<StrikeEntity> getAll() => _box.getAll();

  int insert(StrikeEntity strike) => _box.put(strike);
}
