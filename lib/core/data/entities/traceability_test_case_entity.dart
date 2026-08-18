import 'package:objectbox/objectbox.dart';
import 'package:growth_pilot_ai/core/enum/test_case_result.dart';

/// One validation scenario for a requirement (Issue #238's
/// `test_cases` table, extended by #242 with [tcCode]/[result]).
@Entity()
class TraceabilityTestCaseEntity {
  @Id()
  int id = 0;

  String tcCode;
  String title;
  String description;
  int dbResult; // TestCaseResult index

  TraceabilityTestCaseEntity({
    this.id = 0,
    required this.tcCode,
    required this.title,
    this.description = '',
    this.dbResult = 0,
  });

  TestCaseResult get result => TestCaseResult.values[dbResult];
  set result(TestCaseResult value) => dbResult = value.index;
}
