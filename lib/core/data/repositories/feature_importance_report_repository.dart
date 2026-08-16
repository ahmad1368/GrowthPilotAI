import '../../../../objectbox.g.dart';
import '../entities/feature_importance_report_entity.dart';

/// Thin ObjectBox wrapper for [FeatureImportanceReportEntity] rows
/// (Issue #208).
class FeatureImportanceReportRepository {
  final Box<FeatureImportanceReportEntity> _box;

  FeatureImportanceReportRepository(this._box);

  List<FeatureImportanceReportEntity> getAll() => _box.getAll();

  void add(FeatureImportanceReportEntity report) => _box.put(report);
}
