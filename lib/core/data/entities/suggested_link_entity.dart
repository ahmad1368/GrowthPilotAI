import 'package:objectbox/objectbox.dart';
import 'package:growth_pilot_ai/core/enum/suggested_link_status.dart';
import 'business_goal_entity.dart';
import 'traceable_requirement_entity.dart';

/// "suggested_links: goal_id, req_id, confidence_score, ai_reasoning"
/// (Issue #244's staging table) — a rejected row is kept (not deleted)
/// so [GenerateLinkSuggestions] never re-suggests the same pair (the
/// issue's own "Feedback Loop" AC).
@Entity()
class SuggestedLinkEntity {
  @Id()
  int id = 0;

  final goal = ToOne<BusinessGoalEntity>();
  final requirement = ToOne<TraceableRequirementEntity>();

  double confidenceScore;
  String reasoning;
  int dbStatus; // SuggestedLinkStatus index

  SuggestedLinkEntity({
    this.id = 0,
    required this.confidenceScore,
    required this.reasoning,
    this.dbStatus = 0,
  });

  SuggestedLinkStatus get status => SuggestedLinkStatus.values[dbStatus];
  set status(SuggestedLinkStatus value) => dbStatus = value.index;
}
