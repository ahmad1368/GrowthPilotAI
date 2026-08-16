import 'package:objectbox/objectbox.dart';

/// One persisted `feature_importance_report` event (Issue #208) — no
/// Firebase/BigQuery pipeline is integrated (same decision as #207/#209/
/// #210), so this is the local buffer. Only relative category weights are
/// stored, never dollar amounts (AC: "Zero PII").
@Entity()
class FeatureImportanceReportEntity {
  @Id()
  int id = 0;

  double fixedCostsWeight;
  double variableCostsWeight;
  double laborCostsWeight;
  double externalFactorsWeight;
  String topFeature;
  String industryType;
  DateTime createdAt;

  FeatureImportanceReportEntity({
    this.id = 0,
    required this.fixedCostsWeight,
    required this.variableCostsWeight,
    required this.laborCostsWeight,
    required this.externalFactorsWeight,
    required this.topFeature,
    required this.industryType,
    required this.createdAt,
  });
}
