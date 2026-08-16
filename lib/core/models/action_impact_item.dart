import 'package:flutter/foundation.dart';
import 'package:growth_pilot_ai/core/enum/action_impact_status.dart';

/// One AI recommendation tracked on the Action-Impact roadmap (Issue #260)
/// — [estimatedProfit] and [dailyOpportunityCost] are caller-supplied
/// figures attached when a recommendation is turned into a tracked item,
/// not derived from a live forecasting model (see PR notes).
@immutable
class ActionImpactItem {
  final int id;
  final String title;
  final double estimatedProfit;
  final double dailyOpportunityCost;
  final ActionImpactStatus status;
  final DateTime createdAt;
  final DateTime? completedAt;

  const ActionImpactItem({
    required this.id,
    required this.title,
    required this.estimatedProfit,
    required this.dailyOpportunityCost,
    required this.status,
    required this.createdAt,
    this.completedAt,
  });
}
