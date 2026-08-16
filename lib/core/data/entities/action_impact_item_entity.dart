import 'package:objectbox/objectbox.dart';
import 'package:growth_pilot_ai/core/enum/action_impact_status.dart';

/// Local persistence for one Action-Impact roadmap item (Issue #260's DoD:
/// "Data persists after the app is restarted") — ObjectBox is used since
/// this repo standardizes on it, not the issue's literal Hive/Isar.
@Entity()
class ActionImpactItemEntity {
  @Id()
  int id = 0;

  String title;
  double estimatedProfit;
  double dailyOpportunityCost;
  int dbStatus; // ActionImpactStatus index
  DateTime createdAt;
  @Property(type: PropertyType.date)
  DateTime? completedAt;

  ActionImpactItemEntity({
    this.id = 0,
    required this.title,
    required this.estimatedProfit,
    required this.dailyOpportunityCost,
    required this.dbStatus,
    required this.createdAt,
    this.completedAt,
  });

  ActionImpactStatus get status => ActionImpactStatus.values[dbStatus];
}
