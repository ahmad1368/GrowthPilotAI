import '../../../../objectbox.g.dart';
import '../entities/consent_log_entity.dart';

/// Append-only access to the consent audit trail (Issue #215, AC:
/// "Create-Only. No UPDATE or DELETE operations") — deliberately exposes
/// no update or remove method.
class ConsentLogRepository {
  final Box<ConsentLogEntity> _box;

  ConsentLogRepository(this._box);

  int add(ConsentLogEntity entry) => _box.put(entry);

  List<ConsentLogEntity> getAll() => _box.getAll();
}
