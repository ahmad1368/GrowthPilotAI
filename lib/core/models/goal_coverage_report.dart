import 'package:flutter/foundation.dart';
import 'package:growth_pilot_ai/core/data/entities/business_goal_entity.dart';

/// Local stand-in for Issue #243's `coverage_update` WebSocket payload
/// (`overallCoverage`/`uncoveredGoals`/`timestamp`) — no multi-project
/// concept exists in this repo, so there's no `projectId` field (see
/// PR notes).
@immutable
class GoalCoverageReport {
  final double overallCoverage;
  final List<BusinessGoalEntity> uncoveredGoals;
  final DateTime computedAt;

  const GoalCoverageReport({
    required this.overallCoverage,
    required this.uncoveredGoals,
    required this.computedAt,
  });
}
