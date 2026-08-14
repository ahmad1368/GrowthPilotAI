import 'package:objectbox/objectbox.dart';

/// A manually-logged urgent broadcast dispatched to merchants in one or
/// more Vancouver neighborhoods (Issue #345) — this app has no
/// merchant-directory/push backend, so an admin records the dispatch and
/// its reported delivery/read counts here, the same lightweight logging
/// pattern [PromotionalOfferEntity] uses. [targetNeighborhoods] is a
/// comma-joined list of [VancouverNeighborhood] names.
@Entity()
class EmergencyBroadcastEntity {
  @Id()
  int id = 0;

  String messageBody;

  String targetNeighborhoods;

  int recipientCount;

  int readCount;

  @Index()
  @Property(type: PropertyType.date)
  DateTime dispatchedAt;

  EmergencyBroadcastEntity({
    this.id = 0,
    required this.messageBody,
    required this.targetNeighborhoods,
    required this.recipientCount,
    this.readCount = 0,
    required this.dispatchedAt,
  });
}
