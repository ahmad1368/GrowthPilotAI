import '../../../../objectbox.g.dart';
import '../entities/abuse_report_entity.dart';

/// Thin ObjectBox wrapper for abuse reports (Issue #134).
class AbuseReportRepository {
  final Box<AbuseReportEntity> _box;

  AbuseReportRepository(this._box);

  List<AbuseReportEntity> getAll() => _box.getAll();

  int insert(AbuseReportEntity report) => _box.put(report);
}
