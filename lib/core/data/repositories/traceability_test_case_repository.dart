import '../../../../objectbox.g.dart';
import '../entities/traceability_test_case_entity.dart';

/// Thin ObjectBox wrapper for [TraceabilityTestCaseEntity] rows (Issue
/// #238).
class TraceabilityTestCaseRepository {
  final Box<TraceabilityTestCaseEntity> _box;

  TraceabilityTestCaseRepository(this._box);

  List<TraceabilityTestCaseEntity> getAll() => _box.getAll();

  int upsert(TraceabilityTestCaseEntity testCase) => _box.put(testCase);
}
