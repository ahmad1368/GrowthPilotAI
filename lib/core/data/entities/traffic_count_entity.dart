import 'package:objectbox/objectbox.dart';

/// A manually-logged daily foot and vehicular traffic count (Issue #381)
/// — this app has no municipal sensor/urban movement telemetry feed, so
/// counts are recorded manually here, the same lightweight logging
/// pattern [VisitorCountEntity] uses.
@Entity()
class TrafficCountEntity {
  @Id()
  int id = 0;

  int footTraffic;

  int vehicleTraffic;

  @Index()
  @Property(type: PropertyType.date)
  DateTime date;

  TrafficCountEntity({
    this.id = 0,
    required this.footTraffic,
    required this.vehicleTraffic,
    required this.date,
  });
}
