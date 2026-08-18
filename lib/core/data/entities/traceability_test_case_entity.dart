import 'package:objectbox/objectbox.dart';

/// One validation scenario for a requirement (Issue #238's
/// `test_cases` table).
@Entity()
class TraceabilityTestCaseEntity {
  @Id()
  int id = 0;

  String title;
  String description;

  TraceabilityTestCaseEntity({this.id = 0, required this.title, this.description = ''});
}
