import 'package:objectbox/objectbox.dart';

/// A manually-logged competitor price check (Issue #351) — this app has
/// no scraping/data-ingestion backend for real-time competitor pricing,
/// so a merchant records what they observed at a competitor's storefront
/// or site, the same lightweight logging pattern [WasteLogEntity] uses.
@Entity()
class CompetitorPriceObservationEntity {
  @Id()
  int id = 0;

  String productName;

  String competitorName;

  double ourPrice;

  double competitorPrice;

  @Index()
  @Property(type: PropertyType.date)
  DateTime observedAt;

  CompetitorPriceObservationEntity({
    this.id = 0,
    required this.productName,
    required this.competitorName,
    required this.ourPrice,
    required this.competitorPrice,
    required this.observedAt,
  });
}
