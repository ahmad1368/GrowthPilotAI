import 'package:objectbox/objectbox.dart';

/// One "already on the platform" user for the contact-sync matching
/// simulation (Issue #541, acceptance criteria 3-4) — this app has no
/// real backend/user base, so only SHA-256 hashes are ever stored
/// here, exactly like a real server-side matching table would, and no
/// raw phone/email is ever persisted.
@Entity()
class RegisteredUserDirectoryEntity {
  @Id()
  int id = 0;

  String displayName;

  @Index()
  String hashedPhone;

  @Index()
  String hashedEmail;

  @Property(type: PropertyType.date)
  DateTime addedAt;

  RegisteredUserDirectoryEntity({
    this.id = 0,
    required this.displayName,
    this.hashedPhone = '',
    this.hashedEmail = '',
    required this.addedAt,
  });
}
