import '../../../../objectbox.g.dart';
import '../entities/security_incident_entity.dart';

/// CRUD for logged security incidents (Issue #187) — unlike the audit
/// trail, an incident's [SecurityIncidentEntity.status] legitimately
/// progresses over its lifecycle, so [upsert] is allowed here.
class SecurityIncidentRepository {
  final Box<SecurityIncidentEntity> _box;

  SecurityIncidentRepository(this._box);

  int upsert(SecurityIncidentEntity incident) => _box.put(incident);

  List<SecurityIncidentEntity> getAll() => _box.getAll();
}
