import 'package:flutter/foundation.dart';
import 'package:growth_pilot_ai/core/data/entities/business_goal_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/traceability_test_case_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/traceable_requirement_entity.dart';

/// "Impact Report... DirectlyAffected, IndirectlyAffected, RiskScore"
/// (Issue #240) — computed entirely from this repo's local
/// traceability graph (Issue #238/#239), not a real Python
/// reachability-analysis service (see PR notes).
@immutable
class RequirementImpactReport {
  final List<BusinessGoalEntity> directGoals;
  final List<TraceabilityTestCaseEntity> directTestCases;
  final List<TraceableRequirementEntity> indirectRequirements;
  final List<TraceableRequirementEntity> possibleContradictions;
  final int riskScore;

  const RequirementImpactReport({
    required this.directGoals,
    required this.directTestCases,
    required this.indirectRequirements,
    required this.possibleContradictions,
    required this.riskScore,
  });
}
