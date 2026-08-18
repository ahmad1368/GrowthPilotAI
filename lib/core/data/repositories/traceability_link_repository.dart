import '../../../../objectbox.g.dart';
import '../entities/goal_requirement_link_entity.dart';
import '../entities/requirement_test_case_link_entity.dart';

/// ObjectBox wrapper for both "many-to-many" junction tables (Issue
/// #238's `goal_requirement_map`/`requirement_test_map`) — filters in
/// Dart over `getAll()` rather than a generated query DSL condition,
/// same pattern as this repo's #230 `SearchDocumentChunks`.
class TraceabilityLinkRepository {
  final Box<GoalRequirementLinkEntity> _goalLinks;
  final Box<RequirementTestCaseLinkEntity> _testCaseLinks;

  TraceabilityLinkRepository(this._goalLinks, this._testCaseLinks);

  void linkGoalToRequirement(int goalId, int requirementId) {
    final link = GoalRequirementLinkEntity()
      ..goal.targetId = goalId
      ..requirement.targetId = requirementId;
    _goalLinks.put(link);
  }

  void linkRequirementToTestCase(int requirementId, int testCaseId) {
    final link = RequirementTestCaseLinkEntity()
      ..requirement.targetId = requirementId
      ..testCase.targetId = testCaseId;
    _testCaseLinks.put(link);
  }

  List<GoalRequirementLinkEntity> goalLinksFor({int? goalId, int? requirementId}) {
    return _goalLinks.getAll().where((l) {
      if (goalId != null && l.goal.targetId != goalId) return false;
      if (requirementId != null && l.requirement.targetId != requirementId) return false;
      return true;
    }).toList();
  }

  List<RequirementTestCaseLinkEntity> testCaseLinksFor({required int requirementId}) {
    return _testCaseLinks.getAll().where((l) => l.requirement.targetId == requirementId).toList();
  }

  void removeGoalLinks(int goalId) {
    for (final link in goalLinksFor(goalId: goalId)) {
      _goalLinks.remove(link.id);
    }
  }
}
