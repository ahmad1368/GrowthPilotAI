import 'package:objectbox/objectbox.dart';

/// One high-level project goal (Issue #238's `business_goals` table),
/// e.g. "Reduce customer wait time".
@Entity()
class BusinessGoalEntity {
  @Id()
  int id = 0;

  String title;
  String description;

  BusinessGoalEntity({this.id = 0, required this.title, this.description = ''});
}
