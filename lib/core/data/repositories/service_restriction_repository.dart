import '../../../../objectbox.g.dart';
import '../entities/service_restriction_entity.dart';

/// Basic CRUD for logged service restrictions (Issue #337), mirroring
/// [PromotionalOfferRepository]'s insert/getAll pattern.
class ServiceRestrictionRepository {
  final Box<ServiceRestrictionEntity> _box;

  ServiceRestrictionRepository(this._box);

  int insert(ServiceRestrictionEntity restriction) => _box.put(restriction);

  List<ServiceRestrictionEntity> getAll() => _box.getAll();
}
