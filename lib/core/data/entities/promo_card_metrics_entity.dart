import 'package:objectbox/objectbox.dart';

/// Aggregate impression/click telemetry for one sponsored card injected
/// into the report feed (Issue #402, acceptance criteria 3-4) — this
/// app has no ad-serving backend, so counters are logged locally, the
/// same aggregate-count pattern [PromotionalOfferEntity] (#335) uses
/// instead of a row-per-event log (keeps the feed scroll-performance
/// unaffected, acceptance criterion 4).
@Entity()
class PromoCardMetricsEntity {
  @Id()
  int id = 0;

  @Index()
  int advertisingRequestId;

  int impressionCount;

  int clickCount;

  @Property(type: PropertyType.date)
  DateTime lastImpressionAt;

  PromoCardMetricsEntity({
    this.id = 0,
    required this.advertisingRequestId,
    this.impressionCount = 0,
    this.clickCount = 0,
    required this.lastImpressionAt,
  });
}
