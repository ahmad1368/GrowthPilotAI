import 'package:objectbox/objectbox.dart';

/// An admin-defined permitted radius around a center point for one
/// marketplace feature (Issue #346, acceptance criterion 1) — this app
/// has no live GPS feed, so access is validated against a manually
/// entered lat/lng rather than device location, persisting via
/// ObjectBox `put` (insert when `id == 0`, update in place otherwise)
/// so edits apply immediately.
@Entity()
class GeofenceZoneEntity {
  @Id()
  int id = 0;

  String featureName;

  double centerLatitude;

  double centerLongitude;

  double radiusKm;

  bool isEnabled;

  @Index()
  @Property(type: PropertyType.date)
  DateTime updatedAt;

  GeofenceZoneEntity({
    this.id = 0,
    required this.featureName,
    required this.centerLatitude,
    required this.centerLongitude,
    required this.radiusKm,
    this.isEnabled = true,
    required this.updatedAt,
  });
}
