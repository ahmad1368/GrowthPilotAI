import 'package:objectbox/objectbox.dart';
import 'business_goal_entity.dart';
import 'traceable_requirement_entity.dart';

/// "Which requirements support each business goal" (Issue #238's
/// `goal_requirement_map` many-to-many junction table).
@Entity()
class GoalRequirementLinkEntity {
  @Id()
  int id = 0;

  final goal = ToOne<BusinessGoalEntity>();
  final requirement = ToOne<TraceableRequirementEntity>();

  GoalRequirementLinkEntity({this.id = 0});
}
