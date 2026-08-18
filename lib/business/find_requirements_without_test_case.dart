import 'package:growth_pilot_ai/core/data/entities/requirement_test_case_link_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/traceable_requirement_entity.dart';

/// "'Untested Reqs' filter" (Issue #239) — requirements with no linked
/// test case.
class FindRequirementsWithoutTestCase {
  static List<TraceableRequirementEntity> call(
      List<TraceableRequirementEntity> requirements, List<RequirementTestCaseLinkEntity> allLinks) {
    final linkedIds = allLinks.map((l) => l.requirement.targetId).toSet();
    return requirements.where((r) => !linkedIds.contains(r.id)).toList();
  }
}
