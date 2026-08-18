import 'package:get/get.dart';
import 'package:growth_pilot_ai/core/data/repositories/traceability_link_repository.dart';

/// "Interactive Intersections: each cell... should be an interactive
/// Checkbox" (Issue #239's matrix grid), mixed into
/// `TraceabilityController`.
mixin TraceabilityMatrixLinkMixin on GetxController {
  TraceabilityLinkRepository get linkRepository;
  void refreshAll();

  bool isLinked(int goalId, int requirementId) =>
      linkRepository.goalLinksFor(goalId: goalId, requirementId: requirementId).isNotEmpty;

  void toggleLink(int goalId, int requirementId) {
    if (isLinked(goalId, requirementId)) {
      linkRepository.unlinkGoalFromRequirement(goalId, requirementId);
    } else {
      linkRepository.linkGoalToRequirement(goalId, requirementId);
    }
    refreshAll();
  }
}
