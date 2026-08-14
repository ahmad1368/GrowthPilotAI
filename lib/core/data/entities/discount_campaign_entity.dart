import 'package:objectbox/objectbox.dart';

/// A logged promotional discount campaign (Issue #362) — this app has no
/// POS discount-code backend, so campaigns are recorded manually here, the
/// same lightweight logging pattern [WasteLogEntity] uses.
@Entity()
class DiscountCampaignEntity {
  @Id()
  int id = 0;

  String name;

  double discountPercent;

  @Index()
  @Property(type: PropertyType.date)
  DateTime startDate;

  @Property(type: PropertyType.date)
  DateTime endDate;

  DiscountCampaignEntity({
    this.id = 0,
    required this.name,
    required this.discountPercent,
    required this.startDate,
    required this.endDate,
  });
}
