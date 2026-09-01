import 'package:objectbox/objectbox.dart';
import 'traceable_requirement_entity.dart';
import 'traceability_test_case_entity.dart';

/// "Tracks test coverage for each requirement" (Issue #238's
/// `requirement_test_map` many-to-many junction table).
@Entity()
class RequirementTestCaseLinkEntity {
  @Id()
  int id = 0;

  final requirement = ToOne<TraceableRequirementEntity>();
  final testCase = ToOne<TraceabilityTestCaseEntity>();

  RequirementTestCaseLinkEntity({this.id = 0});
}
