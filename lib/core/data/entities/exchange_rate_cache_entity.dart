import 'package:objectbox/objectbox.dart';

/// "Cache exchange rates for 60 minutes" (Issue #153 AC) — a local
/// stand-in for the Redis cache the NestJS design calls for.
/// [pairKey] is `"$fromCode:$toCode"` (e.g. `"CAD:USD"`) since
/// ObjectBox has no composite-unique-index support.
@Entity()
class ExchangeRateCacheEntity {
  @Id()
  int id = 0;

  @Unique()
  String pairKey;

  double rate;

  @Property(type: PropertyType.date)
  DateTime fetchedAt;

  ExchangeRateCacheEntity({
    this.id = 0,
    required this.pairKey,
    required this.rate,
    required this.fetchedAt,
  });
}
