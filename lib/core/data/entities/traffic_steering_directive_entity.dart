import 'package:objectbox/objectbox.dart';

/// A manually-logged admin traffic-steering directive (Issue #334) —
/// this app has no backend redirect service, so an admin records each
/// steering action here, the same lightweight logging pattern
/// [MerchantBranchEntity] uses.
@Entity()
class TrafficSteeringDirectiveEntity {
  @Id()
  int id = 0;

  String targetName;

  String destinationLabel;

  int redirectCount;

  @Index()
  @Property(type: PropertyType.date)
  DateTime createdAt;

  TrafficSteeringDirectiveEntity({
    this.id = 0,
    required this.targetName,
    required this.destinationLabel,
    required this.redirectCount,
    required this.createdAt,
  });
}
