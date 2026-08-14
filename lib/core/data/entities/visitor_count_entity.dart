import 'package:objectbox/objectbox.dart';

/// A manually-logged daily visitor count (Issue #387) — this app has no
/// optical-counter/web-analytics telemetry, so counts are recorded
/// manually here, the same lightweight logging pattern [WasteLogEntity]
/// uses.
@Entity()
class VisitorCountEntity {
  @Id()
  int id = 0;

  int visitorCount;

  @Index()
  @Property(type: PropertyType.date)
  DateTime date;

  VisitorCountEntity({
    this.id = 0,
    required this.visitorCount,
    required this.date,
  });
}
