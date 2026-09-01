import 'package:objectbox/objectbox.dart';

/// The single manually-set "My Location" row (Issue #213, acceptance
/// criterion "State Persistence") — one row, upserted in place.
/// [lat]/[lng] are stored as full-precision doubles, well beyond the
/// 6-decimal-place accuracy criterion.
@Entity()
class UserLocationPreferenceEntity {
  @Id()
  int id = 0;

  String postalCode;
  double lat, lng;

  @Property(type: PropertyType.date)
  DateTime updatedAt;

  UserLocationPreferenceEntity({
    this.id = 0,
    this.postalCode = '',
    this.lat = 0,
    this.lng = 0,
    required this.updatedAt,
  });
}
