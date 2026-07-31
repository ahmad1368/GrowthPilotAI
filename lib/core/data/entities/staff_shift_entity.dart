import 'package:objectbox/objectbox.dart';

/// A logged staff work shift (Issue #379) — this app has no staff/HR
/// backend, so shifts are recorded manually here, the same lightweight
/// logging pattern [WasteLogEntity] uses.
@Entity()
class StaffShiftEntity {
  @Id()
  int id = 0;

  String staffName;

  @Index()
  @Property(type: PropertyType.date)
  DateTime startTime;

  @Property(type: PropertyType.date)
  DateTime endTime;

  StaffShiftEntity({
    this.id = 0,
    required this.staffName,
    required this.startTime,
    required this.endTime,
  });
}
