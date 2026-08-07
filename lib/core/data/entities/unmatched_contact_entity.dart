import 'package:objectbox/objectbox.dart';

/// One contact from a sync pass that isn't registered on the platform
/// yet (Issue #542, acceptance criterion 1) — unlike the hash-only
/// [RegisteredUserDirectoryEntity] matching table, the raw identifier
/// is kept here on-device (never transmitted anywhere) because the
/// referral engine needs it to actually address an SMS/email/share
/// invite to that contact.
@Entity()
class UnmatchedContactEntity {
  @Id()
  int id = 0;

  @Index()
  String rawIdentifier;

  @Property(type: PropertyType.date)
  DateTime firstSeenAt;

  UnmatchedContactEntity({this.id = 0, required this.rawIdentifier, required this.firstSeenAt});
}
