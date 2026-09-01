import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/compute_goal_coverage_report.dart';
import 'package:growth_pilot_ai/core/data/entities/business_goal_entity.dart';
import 'package:growth_pilot_ai/core/data/repositories/traceability_link_repository.dart';
import 'package:growth_pilot_ai/core/models/goal_coverage_report.dart';

/// "Coverage Sync" (Issue #243) — recomputed reactively every time the
/// graph changes (via [recomputeCoverage], called from `refreshAll`)
/// instead of a 10-15 minute cron job; there's no server-push latency
/// to hide when the write is already local and synchronous (see PR
/// notes). Mixed into `TraceabilityController`.
mixin TraceabilityCoverageMixin on GetxController {
  RxList<BusinessGoalEntity> get goalList;
  TraceabilityLinkRepository get linkRepository;

  final coverageReport = Rxn<GoalCoverageReport>();

  void recomputeCoverage() {
    coverageReport.value = ComputeGoalCoverageReport.call(goalList, linkRepository.goalLinksFor());
  }
}
