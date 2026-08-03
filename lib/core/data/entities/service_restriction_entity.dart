import 'package:objectbox/objectbox.dart';

/// A manually-logged service block/restriction for a merchant (Issue
/// #337) — this app has no backend access-control service, so an admin
/// records each block/unblock decision and its shown reason here, the
/// same lightweight logging pattern [ServiceRestrictionEntity]'s peers
/// ([PromotionalOfferEntity], [AnalyticsPricingTierEntity]) use.
@Entity()
class ServiceRestrictionEntity {
  @Id()
  int id = 0;

  String merchantName;

  String serviceName;

  bool isBlocked;

  String reasonMessage;

  @Index()
  @Property(type: PropertyType.date)
  DateTime updatedAt;

  ServiceRestrictionEntity({
    this.id = 0,
    required this.merchantName,
    required this.serviceName,
    required this.isBlocked,
    required this.reasonMessage,
    required this.updatedAt,
  });
}
