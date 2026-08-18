import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/find_orphaned_requirements_for_goal.dart';
import 'package:growth_pilot_ai/core/data/repositories/business_goal_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/traceability_link_repository.dart';

/// "Consistency Middleware" goal-deletion flow (Issue #238), mixed
/// into `TraceabilityController`.
mixin TraceabilityGoalDeletionMixin on GetxController {
  BusinessGoalRepository get goalRepository;
  TraceabilityLinkRepository get linkRepository;
  void refreshAll();

  List<int> requirementsOrphanedByDeleting(int goalId) =>
      FindOrphanedRequirementsForGoal.call(linkRepository.goalLinksFor(), goalId);

  void deleteGoal(int goalId) {
    goalRepository.delete(goalId);
    linkRepository.removeGoalLinks(goalId);
    refreshAll();
  }
}
