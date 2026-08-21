import 'package:objectbox/objectbox.dart';

/// Single-row "spots remaining" counter for the Founding Member
/// program (Issue #191) — local per-install only; a real cross-user
/// global count needs a shared backend this repo doesn't have (see
/// PR notes).
@Entity()
class FoundingMemberCounterEntity {
  @Id()
  int id = 0;

  int claimedCount;
  int capacity;

  FoundingMemberCounterEntity({this.id = 0, this.claimedCount = 0, this.capacity = 100});
}
