import 'package:objectbox/objectbox.dart';
import 'package:growth_pilot_ai/core/enum/cap_expansion_status.dart';

/// A merchant's request to raise their daily transaction cap, subject
/// to admin review (Issue #344, acceptance criterion 3).
@Entity()
class CapExpansionRequestEntity {
  @Id()
  int id = 0;

  double requestedCapAmount;

  String reason;

  int dbStatus; // CapExpansionStatus index

  @Index()
  @Property(type: PropertyType.date)
  DateTime requestedAt;

  CapExpansionRequestEntity({
    this.id = 0,
    required this.requestedCapAmount,
    required this.reason,
    this.dbStatus = 0, // CapExpansionStatus.pending
    required this.requestedAt,
  });

  CapExpansionStatus get status => CapExpansionStatus.values[dbStatus];
  set status(CapExpansionStatus value) => dbStatus = value.index;
}
