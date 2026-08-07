import 'package:objectbox/objectbox.dart';

/// One matched "friend on the app" result (Issue #541, acceptance
/// criterion 4) — deleted entirely when the user disables contact
/// syncing (criterion 5), not just marked inactive.
@Entity()
class ContactSyncMatchEntity {
  @Id()
  int id = 0;

  String matchedUserName;

  @Property(type: PropertyType.date)
  DateTime matchedAt;

  ContactSyncMatchEntity({this.id = 0, required this.matchedUserName, required this.matchedAt});
}
