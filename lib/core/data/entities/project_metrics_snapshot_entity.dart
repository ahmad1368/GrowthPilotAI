import 'package:objectbox/objectbox.dart';

/// Persisted, flattened [ProjectMetricsSnapshot] (Issue #237's
/// "Offline Engine") — ObjectBox instead of the issue's named Hive,
/// keeping this repo to one local-database technology (see PR notes).
/// Maps/enums don't survive ObjectBox directly, so every field here is
/// a primitive; [ProjectMetricsSnapshotMapper] does the round-trip.
@Entity()
class ProjectMetricsSnapshotEntity {
  @Id()
  int id = 0;

  @Property(type: PropertyType.date)
  DateTime capturedAt;

  int functionalCount;
  int nonFunctionalCount;
  int technicalCount;
  int businessRuleCount;

  double volatilityRate;
  double riskScore;
  double roiEstimate;
  double complexityIndex;
  double completenessRate;
  double engagementRate;

  int riskLow;
  int riskMedium;
  int riskHigh;

  double healthScore;
  String healthLetter;

  ProjectMetricsSnapshotEntity({
    this.id = 0,
    required this.capturedAt,
    required this.functionalCount,
    required this.nonFunctionalCount,
    required this.technicalCount,
    required this.businessRuleCount,
    required this.volatilityRate,
    required this.riskScore,
    required this.roiEstimate,
    required this.complexityIndex,
    required this.completenessRate,
    required this.engagementRate,
    required this.riskLow,
    required this.riskMedium,
    required this.riskHigh,
    required this.healthScore,
    required this.healthLetter,
  });
}
