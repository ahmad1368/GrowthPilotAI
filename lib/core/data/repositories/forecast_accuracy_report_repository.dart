import '../../../../objectbox.g.dart';
import '../entities/forecast_accuracy_report_entity.dart';

/// Thin ObjectBox wrapper for [ForecastAccuracyReportEntity] rows
/// (Issue #207).
class ForecastAccuracyReportRepository {
  final Box<ForecastAccuracyReportEntity> _box;

  ForecastAccuracyReportRepository(this._box);

  List<ForecastAccuracyReportEntity> getAll() => _box.getAll();

  void add(ForecastAccuracyReportEntity report) => _box.put(report);
}
