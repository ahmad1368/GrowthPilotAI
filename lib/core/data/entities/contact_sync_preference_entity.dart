import 'package:objectbox/objectbox.dart';

/// The single user-controlled contact-sync toggle (Issue #541,
/// acceptance criterion 5) — one row, upserted in place.
@Entity()
class ContactSyncPreferenceEntity {
  @Id()
  int id = 0;

  bool isEnabled;

  @Property(type: PropertyType.date)
  DateTime updatedAt;

  ContactSyncPreferenceEntity({this.id = 0, this.isEnabled = true, required this.updatedAt});
}
