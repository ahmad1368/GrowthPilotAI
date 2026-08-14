import 'package:objectbox/objectbox.dart';

/// A manually-logged targeted promotional offer dispatch (Issue #335) —
/// this app has no backend merchant directory/messaging service, so an
/// admin records each dispatch and its logged engagement here, the same
/// lightweight logging pattern [TrafficSteeringDirectiveEntity] uses.
@Entity()
class PromotionalOfferEntity {
  @Id()
  int id = 0;

  String offerText;

  String targetFilter;

  int sentCount;

  int openedCount;

  int usedCount;

  @Index()
  @Property(type: PropertyType.date)
  DateTime dispatchedAt;

  PromotionalOfferEntity({
    this.id = 0,
    required this.offerText,
    required this.targetFilter,
    required this.sentCount,
    required this.openedCount,
    required this.usedCount,
    required this.dispatchedAt,
  });
}
