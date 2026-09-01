import 'package:objectbox/objectbox.dart';
import 'package:growth_pilot_ai/core/enum/procurement_request_status.dart';

/// One "RFP" broadcast to nearby, sector-matched providers (Issue #126)
/// — [neighborhood] is the AC-mandated obfuscated location shown
/// publicly; [centerLat]/[centerLng] stay internal, used only for the
/// eligibility radius match, never displayed raw.
@Entity()
class ProcurementRequestEntity {
  @Id()
  int id = 0;

  @Index()
  String requesterId;

  @Index()
  String sector;

  String summary;
  double budgetMin, budgetMax;
  double centerLat, centerLng, radiusKm;
  String neighborhood;

  @Property(type: PropertyType.date)
  DateTime deadline;

  int dbStatus; // ProcurementRequestStatus index

  @Property(type: PropertyType.date)
  DateTime createdAt;

  ProcurementRequestEntity({
    this.id = 0,
    required this.requesterId,
    required this.sector,
    required this.summary,
    required this.budgetMin,
    required this.budgetMax,
    required this.centerLat,
    required this.centerLng,
    required this.radiusKm,
    required this.neighborhood,
    required this.deadline,
    this.dbStatus = 0,
    required this.createdAt,
  });

  ProcurementRequestStatus get status => ProcurementRequestStatus.values[dbStatus];
  set status(ProcurementRequestStatus value) => dbStatus = value.index;
}
