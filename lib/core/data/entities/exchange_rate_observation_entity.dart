import 'package:objectbox/objectbox.dart';

/// A manually-logged FX rate check against an imported product's landed
/// cost (Issue #371) — this app has no live currency-pair feed, so a
/// merchant records what they observed, the same lightweight logging
/// pattern [CompetitorPriceObservationEntity] uses.
@Entity()
class ExchangeRateObservationEntity {
  @Id()
  int id = 0;

  String currencyPair;

  double baselineRate;

  double currentRate;

  String productName;

  double importCostForeign;

  @Index()
  @Property(type: PropertyType.date)
  DateTime observedAt;

  ExchangeRateObservationEntity({
    this.id = 0,
    required this.currencyPair,
    required this.baselineRate,
    required this.currentRate,
    required this.productName,
    required this.importCostForeign,
    required this.observedAt,
  });
}
